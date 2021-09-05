EESchema Schematic File Version 2
LIBS:ReflowOven-rescue
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:AVR32Board
LIBS:BL600
LIBS:VersaWriter
LIBS:akiduki_components
LIBS:ReflowOven-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 4
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R-RESCUE-ReflowOven R4
U 1 1 538B295D
P 2050 1400
AR Path="/538B295D" Ref="R4"  Part="1" 
AR Path="/538B292E/538B295D" Ref="R4"  Part="1" 
F 0 "R4" V 2150 1400 40  0000 C CNN
F 1 "390" V 2057 1401 40  0000 C CNN
F 2 "" V 1980 1400 30  0000 C CNN
F 3 "" H 2050 1400 30  0000 C CNN
	1    2050 1400
	0    -1   -1   0   
$EndComp
$Comp
L R-RESCUE-ReflowOven R5
U 1 1 538B2B0D
P 2550 1650
AR Path="/538B2B0D" Ref="R5"  Part="1" 
AR Path="/538B292E/538B2B0D" Ref="R5"  Part="1" 
F 0 "R5" V 2630 1650 40  0000 C CNN
F 1 "4.7k" V 2557 1651 40  0000 C CNN
F 2 "" V 2480 1650 30  0000 C CNN
F 3 "" H 2550 1650 30  0000 C CNN
	1    2550 1650
	0    -1   -1   0   
$EndComp
$Comp
L CONN_2 P11
U 1 1 538B2C30
P 3300 1100
F 0 "P11" V 3250 1100 40  0000 C CNN
F 1 "CONN_2" V 3350 1100 40  0000 C CNN
F 2 "" H 3300 1100 60  0000 C CNN
F 3 "" H 3300 1100 60  0000 C CNN
	1    3300 1100
	1    0    0    -1  
$EndComp
Text HLabel 1800 1000 0    60   UnSpc ~ 0
+12V
Text HLabel 1800 1400 0    60   Input ~ 0
CTRL
Text HLabel 1800 1750 0    60   UnSpc ~ 0
GND
$Comp
L NPN Q2
U 1 1 538B3799
P 2700 1400
F 0 "Q2" H 2700 1250 50  0000 R CNN
F 1 "C3325" H 2700 1550 50  0000 R CNN
F 2 "" H 2700 1400 60  0000 C CNN
F 3 "" H 2700 1400 60  0000 C CNN
	1    2700 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 1750 2800 1750
Wire Wire Line
	2800 1750 2800 1600
Wire Wire Line
	2300 1650 2300 1400
Wire Wire Line
	2200 1400 2500 1400
Connection ~ 2300 1400
Wire Wire Line
	1800 1000 2950 1000
Wire Wire Line
	2950 1200 2800 1200
Connection ~ 2800 1650
Wire Wire Line
	1800 1400 1900 1400
Wire Wire Line
	2300 1650 2400 1650
Wire Wire Line
	2700 1650 2800 1650
$EndSCHEMATC
