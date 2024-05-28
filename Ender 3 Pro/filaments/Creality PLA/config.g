set global.filamentType = "PLA"
M221 D0 S96

if global.nozzleDiameter == 0.4
  M572 D0 S0.175
  M207 P0 S5 F3600 Z0
else
  M572 D0 S0
  M207 P0 S3 F3600 Z0
  echo "Warning: Unsupported nozzle diameter"
