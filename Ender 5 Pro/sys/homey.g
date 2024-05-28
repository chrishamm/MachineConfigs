; lift Z
G91 ; relative positioning
G1 H2 Z5 ; move Z relative to current position to avoid dragging nozzle over the bed
G90 ; absolute positioning

; home Y
var maxTravel = move.axes[1].max - move.axes[1].min + 5 ; calculate how far Y can travel plus 5mm
G91
G1 H1 Y{var.maxTravel} F2400 ; coarse home in the +Y direction
G1 H2 Y-5 F6000 ; move back 5mm
G1 H1 Y{var.maxTravel} F400 ; fine home in the +Y direction
G1 H2 Z-5 F6000 ; lower Z again
G90
