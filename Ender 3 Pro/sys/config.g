; Configuration file for Duet 3
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v2.0.4 on Mon Sep 16 2019 12:27:14 GMT+0200 (Central European Summer Time)

; General preferences
G90                                     ; send absolute coordinates...
M83                                     ; ...but relative extruder moves
M550 P"Ender 3 Pro"                     ; set printer name
M912 P0 S-5.1                           ; adjust MCU temperature
M918 P1 E4 F2000000                     ; configure direct-connect display

; Network
M586 C"*"

; IO Mapping
M308 S0 P"temp0" Y"thermistor"
M308 S1 P"temp1" Y"thermistor"
M308 S2 Y"mcutemp" A"MCU"
M950 H0 C"out0" T0
M950 H1 C"out1" T1
M950 H1 C"out1" T1
M950 F0 C"out5"
M950 F1 C"out6"
M950 F2 C"out4"
M950 F3 C"out2" Q25000

; Drives
M569 P0 S0 D2                           ; physical drive 0 goes backwards
;M569.1 P123.0 T2 C5
;M569 P123.0 S0 D0                       ; physical drive 123.0 goes backwards
M569 P1 S0 D2                           ; physical drive 1 goes backwards
M569 P2 S1 D3 V120                      ; physical drive 2 goes forwards
M569 P3 S1 D3 V120                      ; physical drive 3 goes forwards
M569 P4 S0 D3 V100                      ; physical drive 4 goes backwards
M584 X0 Y1 Z2:3 E4                      ; set drive mapping
;M584 X123.0 Y1 Z2:3 E4                  ; set drive mapping
M350 X16 Y16 Z16 E16 I1                 ; configure microstepping with interpolation
M92 X160.00 Y160.00 Z400 E186.00        ; set steps per mm
;M92 X80.00 Y160.00 Z400 E186.00         ; set steps per mm
M566 X1200.00 Y1200.00 Z24.00 E1200.00  ; set maximum instantaneous speed changes (mm/min)
M203 X30000 Y30000 Z450.00 E6000.00     ; set maximum speeds (mm/min)
M201 X3000.00 Y3000.00 Z120.00 E6000.00 ; set accelerations (mm/s^2)
M906 X1000 Y1400 Z800 E1600 I50         ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                 ; Set idle timeout

; Axis Limits
M208 X0 Y0 Z0 S1                        ; set axis minima
M208 X245 Y235 Z240 S0                  ; set axis maxima

; Endstops
M574 P"io0.in" X1 S1
M574 P"io1.in" Y1 S1
M574 P"io5.in+io6.in" Z1 S1

; Z-Probe
M950 S0 C"io3.out"                      ; create servo pin 0 for BLTouch
M558 P9 C"io3.in" H3 F120 T18000        ; set Z probe type to bltouch and the dive height + speeds
G31 P500 X-45 Y-5 Z3.65                 ; set Z probe trigger value, offset and trigger height
M376 H5                                 ; set taper height to 5mm

; Heaters
M307 H0 B0 R0.238 C642.8 D0.81 S1.00 V24.1
M308 S0 T100000 B4092                   ; set thermistor + ADC parameters for heater 0
M143 H0 S150                            ; set temperature limit for heater 0 to 150C
M140 H0
M307 H1 R4.345 K0.744:0.024 D1.95 E1.35 S1.00 B0 V24.2
M308 S1 T100000 B4725 C7.06e-8          ; set thermistor + ADC parameters for heater 1
M143 H1 S275                            ; set temperature limit for heater 1 to 275C

; Fans
M106 P0 S0 I0 F500 H-1                  ; set fan 0 value, PWM signal inversion and frequency. Thermostatic control is turned off
M106 P1 L0.5 X0.8 I0 F500 H1 T60:280    ; set fan 1 value, PWM signal inversion and frequency. Thermostatic control is turned on
M106 P2 L0.5 I0 F500 H2 T50:80          ; set fan 2 value, PWM signal inversion and frequency. Thermostatic control is turned on
M106 P3 S0 I0 F500 H-1 B0 C"LEDs"       ; set fan 3 value, PWM signal inversion and frequency. Thermostatic control is turned off

; DHT22
M308 S3 P"io2.out+io2.in" Y"dht22" A"DHT22 Temp"
M308 S4 P"S3.1" Y"dht-humidity" A"DHT22 Hum[%]"

;M501
M593 P"zvdd" F60                        ; TBD - Y ringing freq 37.5Hz
M80 C"nil"
M955 P0 C"io4.out+io4.in"
M911 S20.8 R23.0 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"
;M915 X S20 R1 F0
;M915 Y S40 R1 F0
M915 E0 S20

; Revo tool config
M98 P"revo/config.g" D0 H1 F0

; Apply filament config
global filamentType = ""
T0                                      ; select first tool
M703                                    ; configure filament

; Job Queue
M98 P"JobQueue/config.g"