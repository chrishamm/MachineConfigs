set global.filamentType = "ABS"
M221 D0 S89

if global.nozzleDiameter == 0.8
  M572 D0 S0.3
  M207 P0 S4 F3600 Z0
else
  M572 D0 S0
  M207 P0 S5 F3000 Z0
  echo "Warning: Unsupported nozzle diameter"
