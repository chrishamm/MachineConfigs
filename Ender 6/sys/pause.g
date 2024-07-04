M83              ; relative extruder moves
G1 E-10 F3600    ; retract 10mm of filament
G91              ; relative positioning
G1 Z5 F360       ; lift Z by 5mm
G90              ; absolute positioning
G1 X145 Y305 F6000 ; go to X=145 Y305

;M150 R255 U255 B0 S72 P50