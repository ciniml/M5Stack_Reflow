EESchema Schematic File Version 2
LIBS:HeaterController_local
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
LIBS:Cypress_BLE
LIBS:akiduki_components
LIBS:HeaterController-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 3
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
L Q_NMOS_GSD Q2
U 1 1 538A2687
P 2850 1950
AR Path="/56BFE5D8/538A2687" Ref="Q2"  Part="1" 
AR Path="/577C5BB5/538A2687" Ref="Q3"  Part="1" 
F 0 "Q3" H 2860 2120 60  0000 R CNN
F 1 "IRLML6344TRPBF" H 3800 1750 60  0000 R CNN
F 2 "TO_SOT_Packages_SMD:SOT-23_Handsoldering" H 2850 1950 60  0001 C CNN
F 3 "" H 2850 1950 60  0000 C CNN
	1    2850 1950
	1    0    0    -1  
$EndComp
$Comp
L R R10
U 1 1 538A268D
P 2100 1950
AR Path="/56BFE5D8/538A268D" Ref="R10"  Part="1" 
AR Path="/577C5BB5/538A268D" Ref="R17"  Part="1" 
F 0 "R17" V 2180 1950 40  0000 C CNN
F 1 "100" V 2107 1951 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 2030 1950 30  0001 C CNN
F 3 "" H 2100 1950 30  0000 C CNN
	1    2100 1950
	0    -1   -1   0   
$EndComp
$Comp
L D D5
U 1 1 538A2693
P 2950 1550
AR Path="/56BFE5D8/538A2693" Ref="D5"  Part="1" 
AR Path="/577C5BB5/538A2693" Ref="D6"  Part="1" 
F 0 "D6" H 2950 1650 40  0000 C CNN
F 1 "1N4148" H 2950 1450 40  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-35_SOD27_Horizontal_RM10" H 2950 1550 60  0001 C CNN
F 3 "" H 2950 1550 60  0000 C CNN
	1    2950 1550
	0    1    1    0   
$EndComp
$Comp
L R R13
U 1 1 538A2699
P 2600 2200
AR Path="/56BFE5D8/538A2699" Ref="R13"  Part="1" 
AR Path="/577C5BB5/538A2699" Ref="R20"  Part="1" 
F 0 "R20" V 2680 2200 40  0000 C CNN
F 1 "10k" V 2607 2201 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 2530 2200 30  0001 C CNN
F 3 "" H 2600 2200 30  0000 C CNN
	1    2600 2200
	0    1    1    0   
$EndComp
$Comp
L R R9
U 1 1 538A269F
P 2100 1350
AR Path="/56BFE5D8/538A269F" Ref="R9"  Part="1" 
AR Path="/577C5BB5/538A269F" Ref="R16"  Part="1" 
F 0 "R16" V 2180 1350 40  0000 C CNN
F 1 "200" V 2107 1351 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 2030 1350 30  0001 C CNN
F 3 "" H 2100 1350 30  0000 C CNN
	1    2100 1350
	0    -1   -1   0   
$EndComp
$Comp
L S216S2 U7
U 1 1 538A26CC
P 4050 1800
AR Path="/56BFE5D8/538A26CC" Ref="U7"  Part="1" 
AR Path="/577C5BB5/538A26CC" Ref="U10"  Part="1" 
F 0 "U10" H 3700 1750 60  0000 C CNN
F 1 "S216S2" H 4300 1750 60  0000 C CNN
F 2 "akiduki_power:S216S02-BEND-HEATSINK" H 4050 1800 60  0001 C CNN
F 3 "" H 4050 1800 60  0000 C CNN
	1    4050 1800
	1    0    0    -1  
$EndComp
$Comp
L ZNR Z1
U 1 1 538A26D2
P 5150 1500
AR Path="/56BFE5D8/538A26D2" Ref="Z1"  Part="1" 
AR Path="/577C5BB5/538A26D2" Ref="Z2"  Part="1" 
F 0 "Z2" H 5150 1600 60  0000 C CNN
F 1 "CNR14D151K" H 5150 1400 60  0000 C CNN
F 2 "akiduki_power:CNR14D151K" H 5150 1500 60  0001 C CNN
F 3 "" H 5150 1500 60  0000 C CNN
	1    5150 1500
	0    -1   -1   0   
$EndComp
Text HLabel 1450 1350 0    60   UnSpc ~ 0
VDD_LOGIC
Text HLabel 1450 1950 0    60   Input ~ 0
SSR_CTRL
Text HLabel 1450 3750 0    60   UnSpc ~ 0
GND_LOGIC
Text HLabel 5350 1300 2    60   UnSpc ~ 0
HEATER
Text HLabel 5350 1700 2    60   UnSpc ~ 0
AC_COMMON
$Comp
L TLP291 U5
U 1 1 577C0917
P 3300 2800
AR Path="/56BFE5D8/577C0917" Ref="U5"  Part="1" 
AR Path="/577C5BB5/577C0917" Ref="U8"  Part="1" 
F 0 "U8" H 3100 3000 50  0000 L CNN
F 1 "TLP291" H 3300 3000 50  0000 L CNN
F 2 "akiduki_opto:SO4" H 3100 2600 50  0001 L CIN
F 3 "" H 3300 2800 50  0000 L CNN
	1    3300 2800
	-1   0    0    -1  
$EndComp
$Comp
L TLP291 U6
U 1 1 577C0BA1
P 3300 3350
AR Path="/56BFE5D8/577C0BA1" Ref="U6"  Part="1" 
AR Path="/577C5BB5/577C0BA1" Ref="U9"  Part="1" 
F 0 "U9" H 3100 3550 50  0000 L CNN
F 1 "TLP291" H 3300 3550 50  0000 L CNN
F 2 "akiduki_opto:SO4" H 3100 3150 50  0001 L CIN
F 3 "" H 3300 3350 50  0000 L CNN
	1    3300 3350
	-1   0    0    -1  
$EndComp
$Comp
L R R14
U 1 1 577C0C18
P 4300 2900
AR Path="/56BFE5D8/577C0C18" Ref="R14"  Part="1" 
AR Path="/577C5BB5/577C0C18" Ref="R21"  Part="1" 
F 0 "R21" V 4380 2900 40  0000 C CNN
F 1 "47k, 1/2" V 4200 3000 40  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 4230 2900 30  0001 C CNN
F 3 "" H 4300 2900 30  0000 C CNN
	1    4300 2900
	0    1    1    0   
$EndComp
$Comp
L R R15
U 1 1 577C0DA5
P 4300 3250
AR Path="/56BFE5D8/577C0DA5" Ref="R15"  Part="1" 
AR Path="/577C5BB5/577C0DA5" Ref="R22"  Part="1" 
F 0 "R22" V 4380 3250 40  0000 C CNN
F 1 "47k, 1/2" V 4200 3350 40  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM10mm" V 4230 3250 30  0001 C CNN
F 3 "" H 4300 3250 30  0000 C CNN
	1    4300 3250
	0    1    1    0   
$EndComp
Wire Wire Line
	2250 1350 3450 1350
Wire Wire Line
	2350 1950 2350 2200
Wire Wire Line
	2250 1950 2650 1950
Wire Wire Line
	2950 2150 2950 3750
Wire Wire Line
	2750 2200 2950 2200
Connection ~ 2950 1350
Connection ~ 2350 1950
Connection ~ 2350 1350
Connection ~ 2950 2200
Wire Wire Line
	4650 1700 5350 1700
Wire Wire Line
	4650 1350 4650 1300
Wire Wire Line
	4650 1300 5350 1300
Connection ~ 5150 1300
Connection ~ 5150 1700
Wire Wire Line
	1450 1350 1950 1350
Wire Wire Line
	1450 1950 1950 1950
Wire Wire Line
	2350 2200 2450 2200
Wire Wire Line
	2950 1350 2950 1400
Wire Wire Line
	2950 1750 2950 1700
Wire Wire Line
	2950 1700 3450 1700
Connection ~ 2950 1700
Wire Wire Line
	3600 2900 3700 2900
Wire Wire Line
	3700 2900 3700 3250
Wire Wire Line
	3600 3250 4150 3250
Wire Wire Line
	3600 2700 3950 2700
Wire Wire Line
	3950 2700 3950 3450
Wire Wire Line
	3950 3450 3600 3450
Wire Wire Line
	4150 2900 3950 2900
Connection ~ 3950 2900
Connection ~ 3700 3250
Wire Wire Line
	2950 3750 1450 3750
Wire Wire Line
	2800 3450 3000 3450
Connection ~ 2950 3450
Wire Wire Line
	2800 2900 3000 2900
Connection ~ 2950 2900
$Comp
L R R11
U 1 1 577C1BC0
P 2500 2600
AR Path="/56BFE5D8/577C1BC0" Ref="R11"  Part="1" 
AR Path="/577C5BB5/577C1BC0" Ref="R18"  Part="1" 
F 0 "R18" V 2580 2600 40  0000 C CNN
F 1 "1k" V 2500 2600 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 2430 2600 30  0001 C CNN
F 3 "" H 2500 2600 30  0000 C CNN
	1    2500 2600
	0    1    1    0   
$EndComp
$Comp
L R R12
U 1 1 577C1D19
P 2500 3150
AR Path="/56BFE5D8/577C1D19" Ref="R12"  Part="1" 
AR Path="/577C5BB5/577C1D19" Ref="R19"  Part="1" 
F 0 "R19" V 2580 3150 40  0000 C CNN
F 1 "1k" V 2500 3150 40  0000 C CNN
F 2 "Resistors_SMD:R_0603_HandSoldering" V 2430 3150 30  0001 C CNN
F 3 "" H 2500 3150 30  0000 C CNN
	1    2500 3150
	0    1    1    0   
$EndComp
Wire Wire Line
	2350 2600 1850 2600
Wire Wire Line
	1850 1350 1850 3150
Connection ~ 1850 1350
Wire Wire Line
	1850 3150 2350 3150
Connection ~ 1850 2600
Wire Wire Line
	2650 2600 2800 2600
Wire Wire Line
	2800 2600 2800 2700
Wire Wire Line
	1450 2700 3000 2700
Wire Wire Line
	2650 3150 2800 3150
Wire Wire Line
	2800 3150 2800 3250
Wire Wire Line
	1450 3250 3000 3250
Connection ~ 2800 2700
Connection ~ 2800 3250
Wire Wire Line
	4900 1300 4900 2900
Wire Wire Line
	4900 2900 4450 2900
Connection ~ 4900 1300
Wire Wire Line
	5000 1700 5000 3250
Wire Wire Line
	5000 3250 4450 3250
Connection ~ 5000 1700
Text HLabel 1450 2700 0    60   Output ~ 0
ZC_OUT_A
Text HLabel 1450 3250 0    60   Output ~ 0
ZC_OUT_B
$Comp
L C_Small C6
U 1 1 577C28AA
P 2800 3350
AR Path="/56BFE5D8/577C28AA" Ref="C6"  Part="1" 
AR Path="/577C5BB5/577C28AA" Ref="C8"  Part="1" 
F 0 "C8" H 2650 3400 50  0000 L CNN
F 1 "100n" H 2550 3250 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 2800 3350 50  0001 C CNN
F 3 "" H 2800 3350 50  0000 C CNN
	1    2800 3350
	1    0    0    -1  
$EndComp
$Comp
L C_Small C5
U 1 1 577C2A05
P 2800 2800
AR Path="/56BFE5D8/577C2A05" Ref="C5"  Part="1" 
AR Path="/577C5BB5/577C2A05" Ref="C7"  Part="1" 
F 0 "C7" H 2650 2850 50  0000 L CNN
F 1 "100n" H 2550 2700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603_HandSoldering" H 2800 2800 50  0001 C CNN
F 3 "" H 2800 2800 50  0000 C CNN
	1    2800 2800
	1    0    0    -1  
$EndComp
$EndSCHEMATC
