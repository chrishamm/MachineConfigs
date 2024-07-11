if fileexists("/sys/daemon.g.bak")
  M472 P"/sys/daemon.g.bak"

while !fileexists("/sys/daemon.g.bak")
  ; Adjust LED strip
  var servoOffset = 75  ; servo value at which the LED strip is straight
  var servoAngle = 95   ; desired angle in deg
  var ledHeight = 85    ; height of the LED strip
  var ledDistance = 240 ; distance of the LED strip from the focus point
  if move.axes[2].machinePosition > 0 && move.axes[2].userPosition + var.ledHeight != 0
      var requestedAngle = 90 - degrees(atan(var.ledDistance / (move.axes[2].machinePosition + var.ledHeight)))
      set var.servoAngle = var.servoOffset + min(max(var.requestedAngle, 0), 90)
  M280 P1 S{var.servoAngle}
    
  ; Wait a second
  G4 S1
