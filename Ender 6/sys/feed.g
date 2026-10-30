; skip the exercise if we're dealing with TPU
if global.filamentType == "TPU"
  M99

; disable filament monitor
var mfmEnabled = sensors.filamentMonitors[0].enableMode
M591 D0 S0

; go to wastebin but don't cross the brush yet
G1 X50 Y145 F15000
G1 Y270
G1 X279
G1 Y306

M106 A

; save PA value and turn off PA
var pa = move.extruders[0].pressAdv.k0
M572 D0 S0

; feed filament to the nozzle until SG detection triggers
M913 E80
G1 E1 F3000
G1 H1 E1800
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

; enable filament monitor
if var.mfmEnabled != 0
  M591 D0 S{var.mfmEnabled}

; assure at least 3mm Z clearance, don't fuck up the nozzle again
if move.axes[2].userPosition < 3
  G1 Z3 F6000
