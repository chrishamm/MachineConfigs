if exists(boards[1])
  if boards[1].firmwareVersion == "3.5.3"
    M291 R"moo" P{"The board is running the CORRECT firmware version. "^boards[1].firmwareVersion} S2
    