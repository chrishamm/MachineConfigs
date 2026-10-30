; Writes all three LED strips: colour from a manual override or the machine state, column window from the bed position
; Call with Z<position> to use a given bed position instead of the live one

var ledCount = 67      ; LEDs per column strip, controlled bottom to top
var topLedCount = 36   ; LEDs on the tiltable top strip
var firstLedAtZ0 = 67  ; lowest column LED that reaches the bed with the bed at the top
var firstLedAtZMax = 8 ; lowest column LED that reaches the bed with the bed fully lowered
var ambient = 25       ; room temperature both ramps are anchored at
var colourSpan = 60    ; bed temperature above ambient that still reads fully red after a print
var fadeSeconds = 900  ; time from reaching ambient to the strips going dark

var red = global.ledWhite[0]
var green = global.ledWhite[1]
var blue = global.ledWhite[2]
var fade = 1
var ramp = -1
if state.status = "paused" || state.status = "pausing"
    set var.red = 255
    set var.green = 255
    set var.blue = 0
elif global.ledJobState = "cancelled"
    set var.red = 255
    set var.green = 0
    set var.blue = 0
elif global.ledJobState = "finished"
    set var.ramp = min(max((heat.heaters[heat.bedHeaterMapping[0][0]].current - var.ambient) / var.colourSpan, 0), 1) * 3
    if var.ramp < 0.1 && global.ledAmbientSince < 0
        set global.ledAmbientSince = state.upTime
    if global.ledAmbientSince >= 0
        set var.fade = max(1 - (state.upTime - global.ledAmbientSince) / var.fadeSeconds, 0)
        ; a finished fade hands over to idle, else it would keep the brightness pinned at zero
        if var.fade <= 0
            set global.ledJobState = ""
            set global.ledAmbientSince = -1
            set global.ledTopBrightness = 0
            set global.ledColumnBrightness = 0
elif global.ledJobState != "printing"
    var progress = 1
    var heating = false
    while iterations < #heat.heaters
        if heat.heaters[iterations] != null && heat.heaters[iterations].active > var.ambient && heat.heaters[iterations].state = "active"
            set var.heating = true
            set var.progress = min(var.progress, (heat.heaters[iterations].current - var.ambient) / (heat.heaters[iterations].active - var.ambient))
    if var.heating
        set var.ramp = min(max(var.progress, 0), 1) * 3

; one scale for both directions: 0 blue at ambient, 1 green, 2 yellow, 3 red at the setpoint or fully hot
if var.ramp >= 0
    if var.ramp > 2
        set var.red = 255
        set var.green = round(255 * (3 - var.ramp))
        set var.blue = 0
    elif var.ramp > 1
        set var.red = round(255 * (var.ramp - 1))
        set var.green = 255
        set var.blue = 0
    else
        set var.red = 0
        set var.green = round(255 * var.ramp)
        set var.blue = round(255 * (1 - var.ramp))

; the manual colours are packed into one value each, because an array written from another channel can be read half-updated
var manualTop = global.ledTopColour
var manualColumn = global.ledColumnColour
var topRed = (var.manualTop < 0) ? var.red : floor(var.manualTop / 65536)
var topGreen = (var.manualTop < 0) ? var.green : floor(mod(var.manualTop, 65536) / 256)
var topBlue = (var.manualTop < 0) ? var.blue : floor(mod(var.manualTop, 256))
var columnRed = (var.manualColumn < 0) ? var.red : floor(var.manualColumn / 65536)
var columnGreen = (var.manualColumn < 0) ? var.green : floor(mod(var.manualColumn, 65536) / 256)
var columnBlue = (var.manualColumn < 0) ? var.blue : floor(mod(var.manualColumn, 256))
var topBrightness = round(global.ledTopBrightness * var.fade)
var columnBrightness = round(global.ledColumnBrightness * var.fade)

var bedZ = exists(param.Z) ? param.Z : move.axes[2].machinePosition
var firstLed = var.firstLedAtZ0 - (var.firstLedAtZ0 - var.firstLedAtZMax) * var.bedZ / move.axes[2].max
; an unhomed bed can be anywhere, so light the whole column instead of guessing a window
var litCount = move.axes[2].homed ? min(max(var.ledCount - round(var.firstLed) + 1, 0), var.ledCount) : var.ledCount

var topColour = var.topRed * 65536 + var.topGreen * 256 + var.topBlue
if var.topColour != global.ledAppliedTopColour || var.topBrightness != global.ledAppliedTopBrightness
    M150 E0 R{var.topRed} U{var.topGreen} B{var.topBlue} P{var.topBrightness} S{var.topLedCount}
    set global.ledAppliedTopColour = var.topColour
    set global.ledAppliedTopBrightness = var.topBrightness

var columnColour = var.columnRed * 65536 + var.columnGreen * 256 + var.columnBlue
if var.columnColour != global.ledAppliedColumnColour || var.columnBrightness != global.ledAppliedColumnBrightness || var.litCount != global.ledAppliedColumnCount
    M150 E1 P0 S{var.ledCount - var.litCount} F1
    M150 E1 R{var.columnRed} U{var.columnGreen} B{var.columnBlue} P{var.columnBrightness} S{var.litCount}
    M150 E2 P0 S{var.ledCount - var.litCount} F1
    M150 E2 R{var.columnRed} U{var.columnGreen} B{var.columnBlue} P{var.columnBrightness} S{var.litCount}
    set global.ledAppliedColumnColour = var.columnColour
    set global.ledAppliedColumnBrightness = var.columnBrightness
    set global.ledAppliedColumnCount = var.litCount
