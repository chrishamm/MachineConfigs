set global.filamentType = "PLA+"
M98 P"extruder.g"

M221 D0 S95

if global.nozzleDiameter == 0.4
  if global.nozzleHighFlow
    M572 D0 S0.7
  else
    M572 D0 S0.475
  M207 P0 S4.5 F3600 Z0
else
  abort "unsupported nozzle diameter in filament config"