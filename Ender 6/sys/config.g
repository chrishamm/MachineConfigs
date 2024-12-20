; Configuration file for RepRapFirmware on Duet 3 Main Board 6HC
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.5.0 on Mon Jun 10 2024 15:58:59 GMT+0200 (Central European Summer Time)

; General
G90                                                               ; absolute coordinates
M83                                                               ; relative extruder moves
M550 P"Ender 6"                                                   ; set hostname

; Accessories
M575 P1 S0 B57600                                                 ; configure PanelDue support

; Wait a moment for the CAN expansion boards to become available
G4 S2

; Accelerometers
M955 P120.0 I20                                                   ; configure accelerometer on board #120

; Smart Drivers
M569 P0.0 S1 D2                                                   ; driver 0.0 goes forwards (Y axis)
M569 P0.1 S0 D2                                                   ; driver 0.1 goes backwards (X axis)
M569 P0.2 S1 D2                                                   ; driver 0.2 goes forwards (Z axis)
M569 P0.3 S1 D2                                                   ; driver 0.3 goes forwards (extruder 0)

; Motor Idle Current Reduction
M906 I30                                                          ; set motor current idle factor
M84 S30                                                           ; set motor current idle timeout

; Axes
M584 X0.1 Y0.0 Z0.2                                               ; set axis mapping
M350 X16 Y16 Z16 I1                                               ; configure microstepping with interpolation
M906 X1000 Y1000 Z800                                             ; set axis driver currents
M92 X80 Y80 Z400                                                  ; configure steps per mm
M208 X9:277 Y2:306 Z0:400                                         ; set minimum and maximum axis limits
M566 X1800 Y1800 Z120 P1                                          ; set maximum instantaneous speed changes (mm/min)
M203 X90000 Y90000 Z1200                                          ; set maximum speeds (mm/min)
M201 X12000 Y12000 Z60                                            ; set accelerations (mm/s^2)
;M566 X600 Y600 Z120 P1                                            ; set maximum instantaneous speed changes (mm/min)
;M203 X30000 Y30000 Z1200                                          ; set maximum speeds (mm/min)
;M201 X4000 Y4000 Z60                                              ; set accelerations (mm/s^2)

; Extruders
M584 E0.3                                                         ; set extruder mapping
M350 E16 I1                                                       ; configure microstepping with interpolation
M906 E1350                                                        ; set extruder driver currents
M92 E837                                                          ; configure steps per mm
M915 E0 S1                                                        ; set StallGuard threshold
M98 P"extruder-defaults.g"

; Kinematics and Input Shaping
M669 K1                                                           ; configure CoreXY kinematics
M593 P"zvdd" F59                                                  ; configure input shaping

; Probes
M558 K0 P9 C"io4.in" H5 F600:120 T12000                           ; configure BLTouch probe via slot #0
G31 P500 X-21 Y-8 Z4.20                                           ; set Z probe trigger value, offset and trigger height
M950 S0 C"io4.out"                                                ; create servo #0 for BLtouch
M280 P0 S160                                                      ; precautionary alarm release
G4 P250
M280 P0 S90                                                       ; ensure the pin is raised

M558 K1 P11 C"120.i2c.ldc1612" F12000 T36000                      ; configure SZP as probe 1, type 11, on CAN address 120
G31 K1 X-21 Y-8 Z0.5                                              ; define probe 1 offsets and trigger height
M558.2 K1 S16 R103896                                             ; set drive current and reading offset

M376 H3                                                           ; taper off at 3mm

; Endstops
M574 X2 P"io1.in" S1                                              ; configure X axis endstop
M574 Y2 P"io2.in" S1                                              ; configure Y axis endstop
M574 Z1 P"io3.in" S1                                              ; configure Z axis endstop

; Sensors
M308 S0 P"temp0" Y"thermistor" A"Heated Bed" T100000 B4092        ; configure sensor #0
M308 S1 P"1.temp0" Y"thermistor" A"Nozzle" T100000 B4388 C7.06e-8 ; configure sensor #1
M308 A"SZP coil" S2 Y"thermistor" P"120.temp0"                    ; thermistor on SZP coil

; Heaters
M950 H0 C"out0" T0                                                ; create heater #0
M143 H0 P0 T0 C0 S140 A0                                          ; configure heater monitor #0 for heater #0
M307 H0 R0.182 K0.161:0.000 D4.93 E1.35 S1.00 B0                  ; configure model of heater #0
M950 H1 C"1.out0" T1                                              ; create heater #1
M143 H1 P0 T1 C0 S285 A0                                          ; configure heater monitor #0 for heater #1
M307 H1 R4.567 K0.694:0.135 D2.00 E1.35 S1.00 B0                  ; configure model of heater #1

; Heated bed
M140 P0 H0                                                        ; configure heated bed #0

; Chamber
M308 S3 P"io6.out" Y"dht22" A"Chamber Temp"
M308 S4 P"S3.1" Y"dht-humidity" A"Chamber RH[%]"

; Fans
M950 F0 C"!1.out3+out3.tach" Q25000                               ; create fan #0
M106 P0 S0 L0.21 X1 B0 H1 T60:250                                 ; configure fan #0
M950 F1 C"1.out6"                                                 ; create fan #1
M106 P1 S0 L0 X1 B0.1 C"Cooling Fan"                              ; configure fan #1

; Tools
M98 P"revo/config.g" D0 H1 F1

; Apply filament config
global filamentType = ""
T0                                                                ; select first tool
M703                                                              ; configure filament

; Configure buzzer
M300 C"io5.out"

; Triggers
M950 J0 C"!io8.in"                                                ; configure gpIn #0
M581 P0 S1 T2 R0                                                  ; configure trigger #2 for gpIn #0

; Servos
M950 S1 C"io7.out"

; LED
M950 E0 C"led" T0 U36
M950 E1 C"1.io0.out" T1 U67 
M950 E2 C"1.io1.out" T1 U67

; Allow cold extrusion
M302 P1