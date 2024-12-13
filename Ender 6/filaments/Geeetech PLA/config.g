M98 P"extruder-defaults.g"

set global.filamentType = "PLA"
M221 D0 S92

if global.nozzleDiameter == 0.4
  M572 D0 S0.7
  M207 P0 S2.5 F3600 Z0
else
  M572 D0 S0
  M207 P0 S3 F3600 Z0
  echo "Warning: Unsupported nozzle diameter"