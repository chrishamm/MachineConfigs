; lower Z
G91 ; relative positioning
G1 H2 Z5 F6000 ; move Z relative to current position to avoid dragging nozzle over the bed
G90 ; absolute positioning

; home XY
var xTravel = move.axes[0].max - move.axes[0].min + 5 ; calculate how far X can travel plus 5mm
var yTravel = move.axes[1].max - move.axes[1].min + 5 ; calculate how far Y can travel plus 5mm
G91 ; relative positioning
G1 H1 X{var.xTravel} Y{var.yTravel} F2400 ; coarse home in the +X and +Y directions
G1 H2 X-2 Y-2
G1 H1 X{var.xTravel} Y{var.yTravel} F300 ; fine home in the +X and +Y directions
G90 ; absolute positioning

; home Z
G1 X160 Y128 F6000
G30

; go to bed center
G1 X118 Y118
