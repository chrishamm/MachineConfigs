M98 P"extruder-tpu.g"

set global.filamentType = "TPU"
M221 D0 S86

if global.nozzleDiameter == 0.4
  M572 D0 S4.6
  M207 P0 S1 F1200 Z0
elif global.nozzleDiameter == 0.8
  M572 D0 S4.1
  M207 P0 S0.5 F1800 Z0
else
  M572 D0 S0
  M207 P0 S0.5 F1800 Z0
  echo "Warning: Unsupported nozzle diameter"
