set global.filamentType = "PLA GITD"
M98 P"extruder.g"

M221 D0 S96

if global.nozzleDiameter == 0.4
  M572 D0 S0.41
  M207 P0 S4 F3600 Z0
elif global.nozzleDiameter == 0.6
  M572 D0 S0.525
  M207 P0 S4 F3600 Z0
else
  abort "unsupported nozzle diameter in filament config"