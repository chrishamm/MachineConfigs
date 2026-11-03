; retract before the nozzle cools, else it oozes a blob while cooling down
if global.filamentType == "TPU"
  G10               ; do only firmware retraction for TPU
else
  G1 E-10 F2400     ; retract
  G1 E-40 F6000     ; retract more

; wipe only if we're at the park position
if abs(move.axes[0].userPosition - 270) < 0.1 && abs(move.axes[1].userPosition - 300) < 0.1
  M98 P"wipe.g"

; turn off heaters
;M140 S0
G10 P0 S0 R0

; turn off fan
M106 S0

; set LEDs
set global.ledJobState = "finished"

; disable extruder
M18 E0
