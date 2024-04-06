let mod = "alt"

let resizeAmount = 100

let movement =
      ''
        # focus window
        ${mod} - h : yabai -m window --focus west
        ${mod} - j : yabai -m window --focus south
        ${mod} - k : yabai -m window --focus north
        ${mod} - l : yabai -m window --focus east
        # swap window
        shift + ${mod} - h : yabai -m window --swap west
        shift + ${mod} - j : yabai -m window --swap south
        shift + ${mod} - k : yabai -m window --swap north
        shift + ${mod} - l : yabai -m window --swap east
        # move display
        shift + ${mod} - 1 : yabai -m display --focus 1
        shift + ${mod} - 2 : yabai -m display --focus 2
        shift + ${mod} - 3 : yabai -m display --focus 3
        shift + ${mod} - 4 : yabai -m display --focus 4
      ''

let resize =
      ''
        # increase window size
        ${mod} - w : yabai -m window --resize top:0:-${Natural/show
                                                         resizeAmount}
        ${mod} - a : yabai -m window --resize left:-${Natural/show
                                                        resizeAmount}:0
        ${mod} - s : yabai -m window --resize bottom:0:${Natural/show
                                                           resizeAmount}
        ${mod} - d : yabai -m window --resize right:${Natural/show
                                                        resizeAmount}:0
        # decrease window size
        shift + ${mod} - w : yabai -m window --resize top:0:${Natural/show
                                                                resizeAmount}
        shift + ${mod} - a : yabai -m window --resize left:${Natural/show
                                                               resizeAmount}:0
        shift + ${mod} - s : yabai -m window --resize bottom:0:-${Natural/show
                                                                    resizeAmount}
        shift + ${mod} - d : yabai -m window --resize right:-${Natural/show
                                                                 resizeAmount}:0
      ''

let action =
      ''
        # toggle window fullscreen zoom
        ${mod} - z : yabai -m window --toggle zoom-fullscreen
        # float window
        ${mod} - f : yabai -m window --toggle float && yabai -m window --grid 10:10:2:1:7:8
        ${mod} - left : yabai -m window --toggle float && yabai -m window --grid 10:10:0:0:5:10
        ${mod} - right : yabai -m window --toggle float && yabai -m window --grid 10:10:5:0:5:10

        ${mod} - v :/Applications/Neovide.app/Contents/MacOS/neovide --frame=none --multigrid
      ''

in  { config =
        ''
          ${movement}
          ${resize}
          ${action}
        ''
    }
