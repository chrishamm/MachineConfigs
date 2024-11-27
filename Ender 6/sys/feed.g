; go to wastebin but don't cross the brush yet
G1 X50 Y145 F15000
G1 Y270
G1 X277
G1 Y306

; push filament into the nozzle unless it's soft TPU
if global.filamentType != "TPU"
  ; save PA value and turn off PA
  var pa = move.extruders[0].pressureAdvance
  M572 D0 S0

  ; feed filament to the nozzle until SG detection triggers
  M913 E30
  G1 E1 F3000
  G1 H1 E100
  M913 E100

  ; start extruding to get the nozzle flowing
  G1 E8 F450
  while iterations < 16
    G1 Y300 E0.5 F3600
    G1 Y306 E0.5

  ; wait a moment to release pressure
  G4 P500

  ; restore PA value and retract
  M572 D0 S{var.pa}
  G10

; move across the brush and then back diagonally
while iterations < 3
  G1 X257 F12000
  G1 Y290
  G1 X277 Y306
  G1 Y300

; move across the brush one last time and then move away from it
G1 Y295
G1 X263
G1 Y306
G1 X252
G1 Y295
