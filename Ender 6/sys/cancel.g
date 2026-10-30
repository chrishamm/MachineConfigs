; retract before the nozzle cools, else it oozes a blob while cooling down
if global.filamentType == "TPU"
  G10               ; do only firmware retraction for TPU
else
  G1 E-10 F2400     ; retract
  G1 E-40 F6000     ; retract more

; see if we're at the park position
if abs(move.axes[0].userPosition - 270) < 0.1 && abs(move.axes[1].userPosition - 300) < 0.1 
  ; move across the brush and then back diagonally
  while iterations < 3
    G1 X260 F12000
    G1 Y290
    G1 X277 Y306
    G1 Y300

  ; move across the brush one last time and then move away from it
  G1 Y295
  G1 X260
  G1 Y300
  G1 Y280
  G1 X252
  G1 X263

; turn off heaters
M140 S0
G10 P0 S0 R0

; turn off fan
M106 S0

; set LEDs
set global.ledJobState = "finished"

; disable extruder
M18 E0
