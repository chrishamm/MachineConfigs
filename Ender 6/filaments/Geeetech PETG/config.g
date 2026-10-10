set global.filamentType = "PETG"
M98 P"extruder.g" D{global.nozzleDiameter}

M221 D0 S95

if global.nozzleDiameter == 0.4
  M572 D0 S0.475
  M207 P0 S3.5 F3600 Z0
elif global.nozzleDiameter == 0.6
  M572 D0 S0.525
  M207 P0 S3.5 F3600 Z0
else
  abort "unsupported nozzle diameter in filament config"