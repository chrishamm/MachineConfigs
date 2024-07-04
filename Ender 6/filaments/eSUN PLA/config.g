set global.filamentType = "PLA"
M221 D0 S90

M566 E1200
M201 E6000

if global.nozzleDiameter == 0.8
  M572 D0 S0.175
  M207 P0 S5 F3600 Z0
elif global.nozzleDiameter == 0.6
  M572 D0 S0.15
  M207 P0 S6 F3600 Z0
else
  M572 D0 S0
  M207 P0 S3 F3600 Z0
  echo "Warning: Unsupported nozzle diameter"