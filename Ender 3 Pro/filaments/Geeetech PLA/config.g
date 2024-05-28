set global.filamentType = "PLA"
M221 D0 S92

if global.nozzleDiameter == 0.15
  M572 D0 S1.4
  M207 P0 S1.5 F3000 Z0
  if state.status == "processing"
    M568 S220
elif global.nozzleDiameter == 0.25
  M572 D0 S0.7
  M207 P0 S2 F3600 Z0
elif global.nozzleDiameter == 0.4
  M572 D0 S0.55
  M207 P0 S3 F3600 Z0
elif global.nozzleDiameter == 0.8
  M572 D0 S0.15
  M207 P0 S5 F3600 Z0
else
  M572 D0 S0
  M207 P0 S3 F3600 Z0
  echo "Warning: Unsupported nozzle diameter"
