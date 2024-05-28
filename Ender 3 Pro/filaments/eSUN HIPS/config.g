set global.filamentType = "HIPS"
M221 D0 S94

if global.nozzleDiameter == 0.8
  M572 D0 S0.275
  M207 P0 S5 F3000 Z0
else
  M572 D0 S0
  M207 P0 S5 F3000 Z0
  echo "Warning: Unsupported nozzle diameter"
