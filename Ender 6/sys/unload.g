var hadToHeat = false
if exists(param.T) && sensors.analog[1].lastReading < param.T
  set var.hadToHeat = true
  M568 S{param.T}
  M116

M302 P1
G1 E-650 F6000
M302 P0

if var.hadToHeat == true
  M568 S0
