; mesh.g
; called to perform mesh bed compensation via G29
;
; generated by RepRapFirmware Configuration Tool v2.0.4 on Mon Sep 16 2019 12:27:14 GMT+0200 (Central European Summer Time)
M561                                    ; clear any bed transform
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  G28                                   ; home all axes

M557 X34:204 Y30:205 S21.25             ; define mesh grid
G29 S0                                  ; probe the bed and enable compensation
