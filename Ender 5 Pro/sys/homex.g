; lift Z
G91 ; relative positioning
G1 H2 Z5 ; move Z relative to current position to avoid dragging nozzle over the bed
G90 ; absolute positioning

; home X
var maxTravel = move.axes[0].max - move.axes[0].min + 5 ; calculate how far X can travel plus 5mm
G91
G1 H1 X{var.maxTravel} F2400 ; coarse home in the +X direction
G1 H2 X-5 F6000 ; move back 5mm
G1 H1 X{var.maxTravel} F300 ; fine home in the +X direction
G1 H2 Z-5 F6000 ; lower Z again
G90
