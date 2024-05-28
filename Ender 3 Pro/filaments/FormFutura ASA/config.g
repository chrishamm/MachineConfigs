set global.filamentType = "ASA"
M221 D0 S85

if global.nozzleDiameter == 0.8
  M572 D0 S0.1
  M207 P0 S5 F3000 Z0
elif global.nozzleDiameter == 0.4
  M572 D0 S0.625
  M207 P0 S4 F3600 Z0
else
  M572 D0 S0
  M207 P0 S5 F3000 Z0
  echo "Warning: Unsupported nozzle diameter"
