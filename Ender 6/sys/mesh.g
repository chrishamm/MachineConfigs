G29 S2
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  G28 ; homeall.g probes Z at the mesh reference point too
else
  G1 Z6 F12000
  G1 X166 Y153 F12000
  G30
if exists(param.K) & param.K=0
  M557 X48:242 Y48:242 S48.5 ;97
else
  G1 Z6  ; to avoid backlash
  M557 X48:242 Y48:242 S10.7
  M558.1 K1 S1
G29 S0 K{exists(param.K) ? param.K : 1}
G1 X145 Y145 F12000
