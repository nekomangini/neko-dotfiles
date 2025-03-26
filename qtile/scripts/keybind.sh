#!/usr/bin/env sh

# This script displays Qtile keybindings using rofi.
KEYBINDINGS=$(
  cat <<'EOF'
  [Window Navigation]
    Mod4 + h              : Move focus to left
    Mod4 + l              : Move focus to right
    Mod4 + j              : Move focus down
    Mod4 + k              : Move focus up

  [Move Windows]
    Mod4 + Shift + h      : Move window to the left
                           (shuffle_left / move_left for treetab)
    Mod4 + Shift + l      : Move window to the right
                           (shuffle_right / move_right for treetab)
    Mod4 + Shift + j      : Move window down
                           (shuffle_down / move_down for treetab)
    Mod4 + Shift + k      : Move window up
                           (shuffle_up / move_up for treetab)

  [Grow or Adjust Windows]
    Mod4 + Ctrl + h       : Grow left (columns) / Shrink (monadtall/monadwide)
    Mod4 + Ctrl + l       : Grow right (columns) / Grow (monadtall/monadwide)
    Mod4 + Ctrl + j       : Grow window down (columns)
                           / Section down (treetab)
    Mod4 + Ctrl + k       : Grow window up (columns)
                           / Section up (treetab)

  [Treetab Layout]
    Mod4 + Shift + a      : Add a new section to TreeTab layout

  [Layout Switching]
    Mod4 + Space          : Toggle between layouts
    Mod4 + Shift + Space  : Toggle to previous layout

  [Group Navigation]
    Mod4 + o              : Go to next group
    Mod4 + i              : Go to previous group
    Mod4 + Tab            : Move to the last visited group

  [Window Control]
    Mod4 + q              : Kill focused window
    Mod4 + Ctrl + r       : Reload the config
    Mod4 + Ctrl + q       : Shutdown Qtile
    Mod4 + f              : Toggle fullscreen on focused window
    Mod4 + m              : Maximize (grow focused client to max)
    Mod4 + n              : Reset all window sizes (normalize/reset layout)
    Mod4 + t              : Toggle floating on the focused window

  [Application Launchers]
    Mod4 + d              : Launch rofi (app launcher)
    Mod4 + Return         : Switch to group "1" and launch terminal
    Mod4 + e              : Switch to group "3" and launch Emacs client
    Mod4 + b              : Switch to group "2" and launch Vivaldi browser
    Mod4 + z              : Switch to group "2" and launch Zen browser
    Mod4 + Shift + g      : Switch to group "1" and launch lazygit via wezterm
    Mod4 + Shift + n      : Switch to group "1" and toggle Ranger (scratchpad)

  [ScratchPad & Dropdowns]
    Mod4 + s              : Show Qtile keybindings
    Mod4 + g              : Toggle Lazygit dropdown (scratchpad)
    Mod4 + Shift + Return : Toggle LunarVim dropdown (scratchpad)

  [System / Misc]
    Print                 : Run screenshot script (Printscreen)
    Mod4 + p              : Launch PowerMenu (exit menu)
    Mod4 + w              : Select window (rofi window switcher)
    Mod4 + Shift + w      : Toggle wallpaper changer dropdown

  [Volume Controls]
    XF86AudioRaiseVolume  : Increase volume
    XF86AudioLowerVolume  : Decrease volume
    XF86AudioMute         : Toggle mute
EOF
)

# Display the cheat sheet using rofi with increased width and two columns.
echo "$KEYBINDINGS" | rofi -dmenu -p "Qtile Keybindings:" \
  -theme-str 'inputbar { enabled: false; }'
