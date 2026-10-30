if fileexists("/sys/daemon.g.bak")
  M472 P"/sys/daemon.g.bak"

var prevZ = move.axes[2].machinePosition
var prevTime = state.upTime + state.msUpTime / 1000

while !fileexists("/sys/daemon.g.bak")
  var bedZ = move.axes[2].machinePosition
  var now = state.upTime + state.msUpTime / 1000
  var dt = var.now - var.prevTime
  var aimZ = var.bedZ
  if move.axes[2].homed && var.dt > 0
    ; the macros take most of a tick, so a frame goes up about (dt - dwell) after its sample and stays for dt - aim at the middle of that
    var lead = max(1.5 * var.dt - 0.2, 0)
    ; extrapolate along the current Z motion, but never past the commanded endpoint
    var target = move.axes[2].userPosition
    set var.aimZ = min(max(var.bedZ + (var.bedZ - var.prevZ) * var.lead / var.dt, min(var.bedZ, var.target)), max(var.bedZ, var.target))
  set var.prevZ = var.bedZ
  set var.prevTime = var.now
  M98 P"/sys/led-top.g" Z{var.aimZ}
  M98 P"/sys/led-apply.g" Z{var.aimZ}
  G4 P200
