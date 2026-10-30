; Sets the LED brightness and colour from the macro buttons and repaints the strips
; T1 addresses the top strip, T2 the two column strips, T0 or no T both
; S<0-255> sets the brightness, R/U/B set a colour that overrides the machine state, A1 hands the colour back to it

var top = !exists(param.T) || param.T != 2
var columns = !exists(param.T) || param.T != 1
if exists(param.S) || exists(param.R)
    ; asking for light ends a cool-down fade, which would otherwise scale the brightness away
    if global.ledAmbientSince >= 0
        set global.ledJobState = ""
        set global.ledAmbientSince = -1
if exists(param.S)
    if var.top
        set global.ledTopBrightness = param.S
    if var.columns
        set global.ledColumnBrightness = param.S
if exists(param.R)
    ; a colour button on a dark strip would do nothing visible, so lift it to 10%
    var colour = round(param.R) * 65536 + round(param.U) * 256 + round(param.B)
    if var.top
        set global.ledTopColour = var.colour
        if global.ledTopBrightness = 0
            set global.ledTopBrightness = 26
    if var.columns
        set global.ledColumnColour = var.colour
        if global.ledColumnBrightness = 0
            set global.ledColumnBrightness = 26
if exists(param.A) && param.A = 1
    if var.top
        set global.ledTopColour = -1
    if var.columns
        set global.ledColumnColour = -1
M98 P"/sys/led-apply.g"
