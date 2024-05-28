; home XY
G91                     ; relative positioning
G1 H2 Z5 F18000         ; lift Z relative to current position
G1 H1 X-260 Y-240 F3000 ; move quickly to X and Y axis endstops and stop there (first pass)
G1 H2 X5 Y5 F6000       ; go back a few mm
G1 H1 X-260 Y-240 F240  ; move slowly to X and Y axis endstops once more (second pass)
G90                     ; absolute positioning

; configure filament
M703

; wait for temps
M116