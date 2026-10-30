M220 S100 ; reset speed factor

set global.ledJobState = "starting"
set global.ledAmbientSince = -1
if global.ledTopBrightness = 0
  set global.ledTopBrightness = 26
if global.ledColumnBrightness = 0
  set global.ledColumnBrightness = 26
; a running job shows its state, so any manual colour goes
M98 P"/sys/led-set.g" A1
