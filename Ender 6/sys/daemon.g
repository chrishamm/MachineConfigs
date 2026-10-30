if fileexists("/sys/daemon.g.bak")
  M472 P"/sys/daemon.g.bak"

var lead = 0.25 ; seconds to look ahead, about one tick plus the time to paint it
var prevZ = move.axes[2].machinePosition
var prevTime = state.upTime + state.msUpTime / 1000

while !fileexists("/sys/daemon.g.bak")
  var bedZ = move.axes[2].machinePosition
  var now = state.upTime + state.msUpTime / 1000
  var aimZ = var.bedZ
  if move.axes[2].homed && var.now > var.prevTime
    ; extrapolate along the current Z motion, but never past the commanded endpoint
    var target = move.axes[2].userPosition
    set var.aimZ = min(max(var.bedZ + (var.bedZ - var.prevZ) * var.lead / (var.now - var.prevTime), min(var.bedZ, var.target)), max(var.bedZ, var.target))
  set var.prevZ = var.bedZ
  set var.prevTime = var.now
  M98 P"/sys/led-top.g" Z{var.aimZ}
  M98 P"/sys/led-apply.g" Z{var.aimZ}
  G4 P200
