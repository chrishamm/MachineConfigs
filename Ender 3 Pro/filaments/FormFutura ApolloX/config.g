set global.filamentType = "ApolloX"
M221 D0 S96

if global.nozzleDiameter == 0.25
  M572 D0 S0.6
  M207 P0 S2 F3600 Z0
elif global.nozzleDiameter == 0.4
  M572 D0 S0.425
  M207 P0 S3 F3600 Z0
elif global.nozzleDiameter == 0.8
  M572 D0 S0.375
  M207 P0 S4 F3600 Z0
else
  M572 D0 S0
  M207 P0 S4 F3600 Z0
  echo "Warning: Unsupported nozzle diameter"
