; called by the button
; if the button remains pressed, unload filament, else load filament
if state.status == "busy"
  while iterations < 3 && sensors.gpIn[0].value > 0
    G4 P250
  if sensors.gpIn[0].value > 0
    M98 P"unload.g"
  else
    M98 P"load.g"
elif state.status == "paused"
  M98 P"feed.g"
