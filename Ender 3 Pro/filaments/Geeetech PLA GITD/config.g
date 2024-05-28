set global.filamentType = "PLA GITD"
M221 D0 S98

if global.nozzleDiameter == 0.6
  M572 D0 S0.325
  M207 P0 S4 F3600 Z0
else
  M572 D0 S0
  M207 P0 S4 F3600 Z0
  echo "Warning: Unsupported nozzle diameter"
