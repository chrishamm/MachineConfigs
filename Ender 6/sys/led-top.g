; Aims the tiltable top strip at the bed, which moves away as Z increases
; Call with Z<position> to aim at a given bed position, else the live one is used

var servoOffset = 75  ; servo value at which the strip points horizontally
var ledHeight = 85    ; height of the strip above the bed at Z0
var ledDistance = 240 ; horizontal distance from the strip to the focus point

var bedZ = exists(param.Z) ? param.Z : move.axes[2].machinePosition
var angle = 90 - degrees(atan(var.ledDistance / (var.bedZ + var.ledHeight)))
M280 P1 S{var.servoOffset + min(max(var.angle, 0), 90)}
