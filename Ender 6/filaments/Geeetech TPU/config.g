M98 P"extruder-tpu.g"

set global.filamentType = "TPU"
M221 D0 S89

if global.nozzleDiameter == 0.6
  M572 D0 S2.7
  M207 P0 S0.5 F1200 Z0
else
  M572 D0 S0
  M207 P0 S0.5 F1200 Z0
  echo "Warning: Unsupported nozzle diameter"
