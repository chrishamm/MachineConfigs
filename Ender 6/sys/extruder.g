if param.D == 0.8
  M566 E1800 ; set maximum instantaneous speed changes (mm/min)
  M203 E6000 ; set maximum speeds (mm/min)
  M201 E6000 ; set accelerations (mm/s^2)
elif param.D == 0.6
  M566 E1800 ; set maximum instantaneous speed changes (mm/min)
  M203 E6000 ; set maximum speeds (mm/min)
  M201 E6000 ; set accelerations (mm/s^2)
elif param.D == 0.4
  M566 E1800 ; set maximum instantaneous speed changes (mm/min)
  M203 E6000 ; set maximum speeds (mm/min)
  M201 E6000 ; set accelerations (mm/s^2)
elif param.D == 0.25
  M566 E1800 ; set maximum instantaneous speed changes (mm/min)
  M203 E6000 ; set maximum speeds (mm/min)
  M201 E6000 ; set accelerations (mm/s^2)
elif param.D == 0.15
  M566 E1800 ; set maximum instantaneous speed changes (mm/min)
  M203 E6000 ; set maximum speeds (mm/min)
  M201 E6000 ; set accelerations (mm/s^2)
else
  abort "unsupported nozzle diameter in extruder config"