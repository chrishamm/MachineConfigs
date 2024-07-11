; check preconditions
M98 P"check-filament.g" F{param.F}
M98 P"revo/check-nozzle.g" S{param.S}

; heat up the bed
M140 S{param.B}
M116

; heat up the nozzle and configure the filament
T0
G10 P0 S{param.T}
M703

; home all axes or calibrate bed
;if move.compensation.type != "none"
  G28
;else
;  G32

; wait for temps and then prime the nozzle
M116
M98 P"feed.g"
