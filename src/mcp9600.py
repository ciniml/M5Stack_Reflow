try:
    from typing import Tuple, Optional, Union
except:
    pass

import machine
import struct

class MCP9600(object):
    "MCP9600 sensor driver"

    REG_HOT_JUNCTION_TEMPERATURE            = const(0x00)
    REG_JUNCTION_TEMPERATURE_DELTA          = const(0x01)
    REG_COLD_JUNCTION_TEMPERATURE           = const(0x02)
    REG_RAW_DATA_ADC                        = const(0x03)
    REG_STATUS                              = const(0x04)
    REG_THERMOCOUPLE_SENSOR_CONFIGURATION   = const(0x05)
    REG_DEVICE_CONFIGURATION                = const(0x06)
    REG_ALERT1_CONFIGURATION                = const(0x08)
    REG_ALERT2_CONFIGURATION                = const(0x09)
    REG_ALERT3_CONFIGURATION                = const(0x0a)
    REG_ALERT4_CONFIGURATION                = const(0x0b)
    REG_ALERT1_HYSTERESIS                   = const(0x0c)
    REG_ALERT2_HYSTERESIS                   = const(0x0d)
    REG_ALERT3_HYSTERESIS                   = const(0x0e)
    REG_ALERT4_HYSTERESIS                   = const(0x0f)
    REG_ALERT1_LIMIT                        = const(0x10)
    REG_ALERT2_LIMIT                        = const(0x11)
    REG_ALERT3_LIMIT                        = const(0x12)
    REG_ALERT4_LIMIT                        = const(0x13)
    REG_DEVICE_ID_REVISION                  = const(0x20)
    
    DEVICE_ID = 0x40

    THERMOCOUPLE_TYPE_K = const(0x00)
    THERMOCOUPLE_TYPE_J = const(0x01)
    THERMOCOUPLE_TYPE_T = const(0x02)
    THERMOCOUPLE_TYPE_N = const(0x03)
    THERMOCOUPLE_TYPE_S = const(0x04)
    THERMOCOUPLE_TYPE_E = const(0x05)
    THERMOCOUPLE_TYPE_B = const(0x06)
    THERMOCOUPLE_TYPE_R = const(0x07)

    ADC_RESOLUTION_18BIT = const(0x0)
    ADC_RESOLUTION_16BIT = const(0x1)
    ADC_RESOLUTION_14BIT = const(0x2)
    ADC_RESOLUTION_12BIT = const(0x3)

    SENSOR_RESOLUTION_0_0625 = const(0)
    SENSOR_RESOLUTION_0_25   = const(1)

    BURST_MODE_SAMPLES_1   = const(0x0)
    BURST_MODE_SAMPLES_2   = const(0x1)
    BURST_MODE_SAMPLES_4   = const(0x2)
    BURST_MODE_SAMPLES_8   = const(0x3)
    BURST_MODE_SAMPLES_16  = const(0x4)
    BURST_MODE_SAMPLES_32  = const(0x5)
    BURST_MODE_SAMPLES_64  = const(0x6)
    BURST_MODE_SAMPLES_127 = const(0x7)

    SHUTDOWN_MODE_NORMAL   = const(0x0)
    SHUTDOWN_MODE_SHUTDOWN = const(0x1)
    SHUTDOWN_MODE_BURST    = const(0x2)
    
    def __init__(self, i2c:machine.I2C, address:int):
        "Constructs the driver for the MCP9600 device on \"i2c\" bus, whose address is \"address\"" 
        self.i2c = i2c
        self.address = address
        self._buffer = memoryview(bytearray(3))

        device_id, major, minor = self.read_device_id()
        if device_id != MCP9600.DEVICE_ID:
            OSError('device id mismatch {X:02}'.format(device_id))
        self.revision_major = major
        self.revision_minor = minor

    def _read_register(self, register:int, buffer:Union[memoryview,bytearray]) -> None:
        "Reads a MCP9600 register value."
        self._buffer[0] = register
        self.i2c.writeto(self.address, self._buffer[0:1])
        self.i2c.readfrom_into(self.address, buffer)
    
    
    def _write_register(self, register:int, buffer:Union[memoryview,bytearray]) -> None:
        "Writes a MCP9600 register value."
        self._buffer[0] = register
        length = len(buffer)
        self._buffer[1:length+1] = buffer
        self.i2c.writeto(self.address, self._buffer[0:length+1])
    
    def read_device_id(self) -> Tuple[int, int, int]:
        "Reads Device ID and Device revisions."
        values = bytearray(2)
        self._read_register(MCP9600.REG_DEVICE_ID_REVISION, values)
        return (values[0], values[1] >> 4, values[1] & 0xf)
    
    def read_temperatures_raw(self) -> Tuple[int, int, int]:
        "Reads raw temperature data (12.4 bit fixed point real number) Returns a triple (hot junction, delta, cold junction)"
        buffer = bytearray(6)
        mv = memoryview(buffer)
        self._read_register(MCP9600.REG_HOT_JUNCTION_TEMPERATURE  , mv[0:2])
        self._read_register(MCP9600.REG_JUNCTION_TEMPERATURE_DELTA, mv[2:4])
        self._read_register(MCP9600.REG_COLD_JUNCTION_TEMPERATURE , mv[4:6])
        return struct.unpack('>hhh', buffer)

    def read_temperatures(self) -> Tuple[float,float,float]:
        "Reads tempreature data. Returns a triple (hot junction, delta, cold junction)"
        hot, delta, cold = self.read_temperatures_raw()
        return hot/16, delta/16, cold/16
    
    def read_raw_data_adc(self) -> int:
        "Reads raw ADC data"
        data = memoryview(bytearray(4))
        data[3] = 0
        self._read_register(MCP9600.REG_RAW_DATA_ADC, data[0:3])
        return struct.unpack('>i', data)[0] >> 8
    
    def read_status(self) -> Tuple[bool,bool,bool,bool,bool,bool,bool]:
        "Reads status. Returns a 7-ple (burst_complete, th_update, input_range, alert_4, alert_3, alert_2, alert_1)"
        buffer = bytearray(1)
        self._read_register(MCP9600.REG_STATUS, buffer)
        data = buffer[0]
        return ((data & 0x80) != 0, (data & 0x40) != 0, (data & 0x10) != 0, (data & 0x08) != 0, (data & 0x04) != 0, (data & 0x02) != 0, (data & 0x01) != 0)
    
    def clear_status(self, clear_burst_complete:bool=False, clear_th_update:bool=False) -> None:
        "Clears status bits."
        value = bytearray(1)
        value[0]  = 0x80 if clear_burst_complete else 0x00 
        value[0] |= 0x40 if clear_th_update else 0x00 
        self._write_register(MCP9600.REG_STATUS, value)
    
    def read_sensor_configuration(self) -> Tuple[int,int]:
        "Reads sensor configuration. Returns a tuple (thermocouple_type, filter_coefficient)"
        buffer = bytearray(1)
        self._read_register(MCP9600.REG_THERMOCOUPLE_SENSOR_CONFIGURATION, buffer)
        data = buffer[0]
        return ((data>>4)&7, data&3)
    
    def write_sensor_configuration(self, thermocouple_type:int, filter_coefficient:int) -> None:
        "Writes sensor configuration"
        value = bytearray(1)
        value[0] = ((thermocouple_type&7)<<4) | (filter_coefficient&7)
        self._write_register(MCP9600.REG_THERMOCOUPLE_SENSOR_CONFIGURATION, value)
    
    def read_device_configuration(self) -> Tuple[int,int,int,int]:
        "Reads device configuration. Retuns a tuple (sensor_resolution, adc_resolution, burst_mode_samples, shutdown_mode)"
        buffer = bytearray(1)
        self._read_register(MCP9600.REG_DEVICE_CONFIGURATION, buffer)
        data = buffer[0]
        return (data>>7, (data>>5) & 3, (data>>2)&7, data&3)
    
    def write_device_configuration(self, sensor_resolution:int, adc_resolution:int, burst_mode_samples:int, shutdown_mode:int) -> None:
        "Writes device configuration"
        value = bytearray(1)
        value[0] = ((sensor_resolution&1)<<7) | ((adc_resolution&2)<<5) | ((burst_mode_samples&7)<<2) | (shutdown_mode&3)
        self._write_register(MCP9600.REG_DEVICE_CONFIGURATION, value)
