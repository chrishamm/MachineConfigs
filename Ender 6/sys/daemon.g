if fileexists("/sys/daemon.g.bak")
  M472 P"/sys/daemon.g.bak"

while !fileexists("/sys/daemon.g.bak")
  var bedZ = move.axes[2].machinePosition
  M98 P"/sys/led-top.g" Z{var.bedZ}
  M98 P"/sys/led-apply.g" Z{var.bedZ}
  G4 P200
