G1 R1 X0 Y0 Z5 F6000 ; go to 5mm above position of the last print move
G1 R1 X0 Y0          ; go back to the last print move
M83                  ; relative extruder moves
G1 E10 F3600         ; extrude 10mm of filament

;M150 R0 U255 B0 S72 P50