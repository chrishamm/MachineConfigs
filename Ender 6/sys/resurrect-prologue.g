; home XY
var xTravel = move.axes[0].max - move.axes[0].min + 5
var yTravel = move.axes[1].max - move.axes[1].min + 5
G91                                            ; relative positioning
G1 H2 Z5 F1200                                 ; lift Z relative to current position
G1 H1 X{var.xTravel} Y{var.yTravel} F1500      ; coarse home towards the X and Y max endstops
G1 H1 X{var.xTravel} F1500                     ; coarse home in the +X direction
G1 H1 Y{var.yTravel} F1500                     ; coarse home in the +Y direction
G1 X-5 Y-5 F6000                               ; move back 5mm
G1 H1 X{var.xTravel} Y{var.yTravel} F600       ; fine home
G1 H1 X{var.xTravel} F600                      ; fine home in the +X direction
G1 H1 Y{var.yTravel} F600                      ; fine home in the +Y direction
G90                                            ; absolute positioning

; configure filament
M703

; wait for temps
M116
