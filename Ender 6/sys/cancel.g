; retract before the nozzle cools, else it oozes a blob while cooling down
if global.filamentType == "TPU"
  G10               ; do only firmware retraction for TPU
else
  G1 E-10 F2400     ; retract
  G1 E-40 F6000     ; retract more
;M140 S0
G10 P0 S0 R0
M106 S0
set global.ledJobState = "cancelled"
M84 E0
