try:
    from typing import Tuple, Optional, Union, List
except:
    pass

import machine
import mcp9600
import m5stack
import logging
import time
import uasyncio as asyncio
import gc

lcd = m5stack.lcd
l = logging.Logger('MAIN')

# Initializing RTC
rtc = machine.RTC()
rtc.init((2019,4,30,0,0,0))
rtc.ntp_sync(server='ntp.jst.mfeed.ad.jp')

l.info('Syncing clock...')
while not rtc.synced():
    time.sleep_ms(1000)

# Initialize temperature sensors
l.info('Scanning I2C bus...')
i2c = machine.I2C(sda=machine.Pin(21), scl=machine.Pin(22), freq=100000)
i2c_devices = i2c.scan()
l.info('Devices found: ' + str(i2c_devices))

mcp9600_addr = None
for i2c_device in i2c_devices:
    if 0x60 <= i2c_device <= 0x62:
        mcp9600_addr = i2c_device
        break

if mcp9600_addr is None:
    raise OSError('Error: could not detect MCP9600 device.')

tc = mcp9600.MCP9600(i2c=i2c, address=mcp9600_addr)
t = tc.read_temperatures()
l.info("Current temperature sensor reading: " + str(t))

# Initialize SSR control pins.
pwm_ssrs = [machine.PWM(x, freq=4, duty=0, timer=2) for x in (2, 5)]

class HeaterController(object):
    def __init__(self, tc:mcp9600.MCP9600, ssrs:List[machine.PWM], log_file=None):
        self.tc = tc
        self.ssrs = ssrs
        self.target_temperature = 0
        self.last_temperature = 0
        self.output_upper = 0
        self.output_lower  = 0
        self.yp = 0
        self.ep = 0
        self.ei = 0
        self.kp = 0
        self.ki = 0
        self.kd = 0
        self.do_init = True
        self.log_file = log_file

    def init(self):
        self.do_init = True

    def shutdown(self):
        self.ssrs[0].duty(0)
        self.ssrs[1].duty(0)

    def update(self):
        y, _, _ = self.tc.read_temperatures()
        if self.do_init:
            self.do_init = False
            self.last_temperature = 0
            self.yp = y
            self.ep = 0
            self.ei = 0
                    
        self.last_temperature = y
        e = self.target_temperature - y
        ed = e - self.ep
        self.ep = e
        
        p = e * self.kp
        self.ei += e if -100 <= p and p <= 100 else 0
        i = self.ei * self.ki
        d = ed * self.kd

        output = p + i + d
        self.yp = y
        
        output_clamped = output
        if output_clamped < 0:
            output_clamped = 0
        elif output_clamped > 100:
            output_clamped = 100
        self.yp = y
        
        # Apply output to SSR 
        self.ssrs[0].duty(output_clamped)
        self.ssrs[1].duty(output_clamped/2)

        l.info('target:{:+.5g}, output:{:+.5g}, clamped:{:+.5g}, y:{:+.5g}, p:{:+.5g}, i:{:+.5g}, d:{:+.5g}'.format(self.target_temperature, output, output_clamped, y, p, i, d))
        if self.log_file is not None:
            self.log_file.write('{},{},{},{},{},{},{}\n'.format(self.target_temperature, output, output_clamped, y, p, i, d))

def measure(output:int, seconds:int=300) -> None:
    temperature, _, ambient = tc.read_temperatures()
    log_path = '/sd/micropython/reflow/reflow_{}_{}.log'.format(output, ambient)
    with open(log_path, 'w') as f:
        pwm_ssrs[0].duty(output)
        pwm_ssrs[1].duty(output/4)
        last_temperature = temperature
        for _ in range(seconds):
            temperature, _, __ = tc.read_temperatures()
            f.write('{}\n'.format(temperature))
            diff = temperature - last_temperature
            l.info('{}, {}'.format(temperature, diff))
            last_temperature = temperature
            time.sleep_ms(1000)

    pwm_ssrs[0].duty(0)
    pwm_ssrs[1].duty(0)

hc = None
timer = None
log_file = None
def tuning_start(target:int=220, kp:float=0):
    global hc
    global timer
    global log_file
    log_file = open('/sd/micropython/reflow/reflow_tune_{}_{}.csv'.format(target, kp), 'w')
    hc = HeaterController(tc=tc, ssrs=pwm_ssrs, log_file=log_file)
    hc.kp = kp
    hc.target_temperature = target
    hc.init()
    timer = machine.Timer(3)
    timer.init(period=250, mode=timer.PERIODIC, callback=lambda _: hc.update())

def tuning_stop():
    timer.deinit()
    hc.shutdown()
    log_file.close()

def calc_params(kp:float=35, tc:float=77):
    return (0.6*kp, 1.2*kp/tc, 0.075*kp*tc)

class CancellationToken(object):
    def __init__(self):
        self.cancelled = False
    def is_cancelled(self) -> bool:
        return self.cancelled
    def cancel(self) -> None:
        self.cancelled = True
    def throw_if_cancelled(self) -> None:
        if self.cancelled:
            raise asyncio.CancelledError()

class ReflowController(object):
    def __init__(self, tc:mcp9600.MCP9600) -> None:
        self.table = [(60,0,'Ramp to initial temperature'), (150,90, 'Ramp to soak'), (180,30, 'Soak'), (230,60, 'Ramp to reflow'), (230,5,'Reflow')]
        self.running = False

    def start(self, loop:asyncio.EventLoop) -> None:
        if not self.running:
            self.token = CancellationToken()
            loop.create_task(self.run_reflow(cancel=self.token))
            self.running = True

    def stop(self) -> None:
        if self.running:
            self.token.cancel()

    async def run_reflow(self, tune_kp:float=35.0, tune_tc:float=77.0, cancel:CancellationToken=CancellationToken()):
        log_file = open('/sd/micropython/reflow/reflow_run_{}_{}.csv'.format(tune_kp, tune_tc), 'w')
        hc = HeaterController(tc=tc, ssrs=pwm_ssrs, log_file=log_file)
        hc.kp, hc.ki, hc.kd = calc_params(kp=tune_kp, tc=tune_tc)
        hc.init()
        timer = machine.Timer(3)
        timer.init(period=250, mode=timer.PERIODIC, callback=lambda _: hc.update())

        m5stack.speaker.tone(1760, volume=3)

        try:
            last_row = None # type: Optional[Tuple[float,float,str]]
            for row in self.table:
                l.info('### {}: {} - {}'.format(row[2], row[0], row[1]))
                count = 0
                while (hc.last_temperature < row[0] and row[1] == 0) or count < row[1]*8:
                    hc.target_temperature = last_row[0] + (row[0] - last_row[0])*count/(row[1]*8) if last_row is not None else row[0]
                    await asyncio.sleep_ms(125)
                    cancel.throw_if_cancelled()
                    count += 1
                last_row = row
            l.info('### Finished.')
            m5stack.speaker.tone(1760, volume=3)
            m5stack.speaker.tone(1760, volume=3)
            m5stack.speaker.tone(1760, volume=3)

        finally:
            timer.deinit()
            hc.shutdown()
            log_file.close()
            self.running = False

loop = asyncio.get_event_loop()

async def main_task():
    rc = ReflowController(tc=tc)
    while True:
        if m5stack.buttonA.isPressed():
            rc.start(loop)
        elif m5stack.buttonB.isPressed():
            rc.stop()
            m5stack.speaker.tone(440, volume=3)
        await asyncio.sleep_ms(500)

gc.collect()

loop.create_task(main_task())
loop.run_forever()

