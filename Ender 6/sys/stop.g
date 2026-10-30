M140 S0                             ; turn off bed
G10 P0 S0 R0                        ; turn off nozzle
M106 S0                             ; turn off fan

if global.filamentType == "TPU"
  G10                               ; do only firmware retraction for TPU
else
  G1 E-10 F2400                     ; retract
  G1 E-40 F6000                     ; retract more

G91
G1 Z2 F1200                         ; lift the nozzle off the last layer
G90

set global.ledJobState = "finished" ; update LEDs
G1 X270 Y300 F12000                 ; move the head out of the way

M291 R"Print Finished" P"Press OK to lower the bed" S3
G1 Z400                             ; move bed down