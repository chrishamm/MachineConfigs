if !move.axes[2].homed
  G28
G29 ; call mesh bed compensation
;M561