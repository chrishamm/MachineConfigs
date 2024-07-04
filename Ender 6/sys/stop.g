G1 X145 Y305 F12000 ; move the head out of the way
if global.filamentType == "TPU"
  G10               ; do only firmware retraction for TPU
else
  G1 E-10 F2400     ; retract
  G1 E-40 F6000     ; retract more
M140 S0             ; turn off bed
G10 P0 S0 R0        ; turn off nozzle
M106 S0
G1 Z400             ; move bed down
M84
;M150 P0 S72
