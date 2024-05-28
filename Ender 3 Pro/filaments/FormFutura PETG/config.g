set global.filamentType = "PETG"
M221 D0 S98
if state.status == "processing"
  G10 P0 S220 ; we need 220C instead of 240C for HDglass

if global.nozzleDiameter == 0.6
  M572 D0 S0.6
  M207 P0 S6 F3000 Z0
else
  M572 D0 S0
  M207 P0 S5 F3000 Z0
  echo "Warning: Unsupported nozzle diameter"
