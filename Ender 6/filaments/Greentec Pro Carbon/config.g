M98 P"extruder-defaults.g"

set global.filamentType = "GreenTec Carbon"
M221 D0 S79

if global.nozzleDiameter == 0.6
  M572 D0 S0.19
  M207 P0 S4.5 F3000 Z0
else
  M572 D0 S0
  M207 P0 S4 F3600 Z0
  echo "Warning: Unsupported nozzle diameter"
