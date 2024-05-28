set global.filamentType = "TPU"
M221 D0 S93

if global.nozzleDiameter == 0.8
  M572 D0 S1
  M207 P0 S5 F2400 Z0
elif global.nozzleDiameter == 0.6
  M572 D0 S1
  M207 P0 S5 F2400 Z0
else
  M572 D0 S0
  M207 P0 S5 F3000 Z0
  echo "Warning: Unsupported nozzle diameter"
