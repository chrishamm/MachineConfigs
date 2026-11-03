; skip the exercise if we're dealing with TPU
if global.filamentType == "TPU"
  M99

; disable filament monitor
var mfmEnabled = sensors.filamentMonitors[0].enableMode
M591 D0 S0

; go to wastebin via the park position, a direct path can hit the rear beam
G1 X270 Y300 F15000
G1 X279 Y306

; save PA value and turn off PA
var pa = exists(move.extruders[0].pressAdv) ? move.extruders[0].pressAdv.k0 : move.extruders[0].pressureAdvance
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

M98 P"wipe.g"

; enable filament monitor
if var.mfmEnabled != 0
  M591 D0 S{var.mfmEnabled}

; assure at least 3mm Z clearance, don't fuck up the nozzle again
if move.axes[2].userPosition < 3
  G1 Z3 F6000
