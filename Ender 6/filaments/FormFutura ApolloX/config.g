set global.filamentType = "ApolloX"
M221 D0 S97

if global.nozzleDiameter == 0.6
  M572 D0 S0.7
  M207 P0 S3 F3600 Z0
else
  M572 D0 S0
  M207 P0 S5 F3000 Z0
  echo "Warning: Unsupported nozzle diameter"
