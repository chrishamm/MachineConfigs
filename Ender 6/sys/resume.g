; move across the brush and then back diagonally
while iterations < 3
  G1 X257 F12000
  G1 Y290
  G1 X277 Y306
  G1 Y300

; move across the brush one last time and then move away from it
G1 Y295
G1 X263
G1 Y300
G1 Y280
G1 X252

; resume
G1 R1 X0 Y0 Z5 F18000 ; go to 5mm above position of the last print move
G1 R1 X0 Y0           ; go back to the last print move
M83                   ; relative extruder moves
G1 E10 F3600          ; extrude 10mm of filament

;M150 R0 U255 B0 S72 P50