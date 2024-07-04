M906 E1500                                                      ; set extruder driver currents
M92 E140                                                        ; configure steps per mm
M566 E1800                                                      ; set maximum instantaneous speed changes (mm/min)
M203 E6000                                                      ; set maximum speeds (mm/min)
M201 E12000                                                     ; set accelerations (mm/s^2)
M915 E0 S3                                                      ; set StallGuard threshold
