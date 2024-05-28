set global.filamentType = "PETG"
M221 D0 S97

if global.nozzleDiameter == 0.4
  M572 D0 S1.3
  M207 P0 S2 F6000 Z0
elif global.nozzleDiameter == 0.6
  M572 D0 S0.6
  M207 P0 S3 F4200 Z0
else
  M572 D0 S0
  M207 P0 S5 F3000 Z0
  echo "Warning: Unsupported nozzle diameter"
