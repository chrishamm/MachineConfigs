; configure XY motor settings for sensorless homing
M569 P0.0 D3 V100 ; use StealthChop for X
M569 P0.1 D3 V100 ; use StealthChop for Y
M913 X30 Y30 ; reduce motor currents

; configure endstops
M574 X1 S3 ; configure X axis endstop
M574 Y1 S3 ; configure Y axis endstop
M915 X Y S1 R0 F0 ; configure SG

; home XY at 60mm/s and once again at 50mm/s
var xTravel = move.axes[0].max - move.axes[0].min + 5 ; calculate how far X can travel plus 5mm
var yTravel = move.axes[1].max - move.axes[1].min + 5 ; calculate how far Y can travel plus 5mm
G91                                                   ; relative positioning
G1 H1 X{-var.xTravel} Y{-var.yTravel} F3600           ; coarse home
G1 H1 X{-var.xTravel} F3600                           ; coarse home in the -X direction
G1 H1 Y{-var.yTravel} F3600                           ; coarse home in the -Y direction
G1 X5 Y5 F6000                                        ; move back 5mm
G1 H1 X{-var.xTravel} Y{-var.yTravel} F3000           ; fine home
G1 H1 X{-var.xTravel} F3000                           ; fine home in the -X direction
G1 H1 Y{-var.yTravel} F3000                           ; fine home in the -Y direction
G90                                                   ; absolute positioning

; restore XY motor settings
M569 P0.0 D2 ; use SpreadCycle for X
M569 P0.1 D2 ; use SpreadCycle for Y
M913 X100 Y100 ; restore motor currents
