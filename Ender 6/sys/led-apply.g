; Writes all three LED strips: colour from the machine state, column window from the bed position
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
var brightness = global.ledBrightness
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
    if var.ramp = 0 && global.ledAmbientSince < 0
        set global.ledAmbientSince = state.upTime
    if global.ledAmbientSince >= 0
        set var.brightness = round(global.ledBrightness * max(1 - (state.upTime - global.ledAmbientSince) / var.fadeSeconds, 0))
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

var bedZ = exists(param.Z) ? param.Z : move.axes[2].machinePosition
var firstLed = var.firstLedAtZ0 - (var.firstLedAtZ0 - var.firstLedAtZMax) * var.bedZ / move.axes[2].max
var litCount = min(max(var.ledCount - round(var.firstLed) + 1, 0), var.ledCount)
var colour = var.red * 65536 + var.green * 256 + var.blue
if var.brightness != global.ledAppliedBrightness || var.bedZ != global.ledAppliedZ || var.colour != global.ledAppliedColour
    M150 E0 R{var.red} U{var.green} B{var.blue} P{var.brightness} S{var.topLedCount}
    M150 E1 P0 S{var.ledCount - var.litCount} F1
    M150 E1 R{var.red} U{var.green} B{var.blue} P{var.brightness} S{var.litCount}
    M150 E2 P0 S{var.ledCount - var.litCount} F1
    M150 E2 R{var.red} U{var.green} B{var.blue} P{var.brightness} S{var.litCount}
    set global.ledAppliedBrightness = var.brightness
    set global.ledAppliedZ = var.bedZ
    set global.ledAppliedColour = var.colour
    set global.ledAppliedCount = var.litCount
