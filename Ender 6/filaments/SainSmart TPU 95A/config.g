set global.filamentType = "TPU"
M98 P"extruder.g" D{global.nozzleDiameter}

M221 D0 S96

if global.nozzleDiameter == 0.4
  M572 D0 S1.2
  M207 P0 S0.5 F1200 Z0
else
  abort "unsupported nozzle diameter in filament config"