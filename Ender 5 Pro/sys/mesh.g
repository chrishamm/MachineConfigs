T-1
G29 S2
G1 X160 Y128 Z5 F6000
G30
if exists(param.K) & param.K=1
  G1 Z6  ; to avoid backlash
  M558.1 K1 S0.5
G29 S0 K{exists(param.K) ? param.K : 0}
G1 X160 Y128 F6000
