if true
  M302 P1
  G1 E-500 F6000
  M302 P0
else
  var hadToHeat = false
  if sensors.analog[1].lastReading < param.T
    set var.hadToHeat = true
    T0
    M568 S{param.T}
    M116

  G1 E-500 F6000

  if var.hadToHeat == true
    M568 S0
