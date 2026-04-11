{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    # VARIABLES
    $mainMod = SUPER

    # MY PROGRAMS
    $terminal = kitty
    $tmux = kitty -e tmux new-session -A -s main
    $fileManager = dolphin
    $doom = emacsclient -c
    $menu = fuzzel

    # KEYBINDINGS

    # Window management
    bind = $mainMod, X,            exec, pkill -SIGUSR1 waybar # NOTE: Toggle waybar
    bind = $mainMod, T,            togglesplit,
    bind = $mainMod, V,            togglefloating,
    bind = $mainMod, Q,            killactive,
    bind = $mainMod  CTRL, q,      exit,
    bind = $mainMod, F,            fullscreen, 0
    bind = $mainMod, M,            fullscreen, 1

    # Group management
    bind = $mainMod, G, togglegroup                            # NOTE: Create/destroy a group from the active window
    bind = $mainMod SHIFT, G, lockactivegroup, toggle          # NOTE: Lock/unlock the active group
    bind = $mainMod, U, moveoutofgroup                         # NOTE: Remove from group

    # Cycle through windows inside the group
    bind = ALT, L, changegroupactive, f
    bind = ALT, H, changegroupactive, b

    # Rearrange the order of windows inside the group
    bind = ALT SHIFT, L, movegroupwindow, f
    bind = ALT SHIFT, H, movegroupwindow, b

    # Move a window into the group in a direction
    bind = $mainMod ALT, H, moveintogroup, l
    bind = $mainMod ALT, L, moveintogroup, r
    bind = $mainMod ALT, K, moveintogroup, u
    bind = $mainMod ALT, J, moveintogroup, d

    # Launch applications
    bind = $mainMod, RETURN,       exec, $terminal
    bind = $mainMod  CTRL, RETURN, exec, $tmux
    bind = $mainMod, D, exec,      $menu
    bind = $mainMod, E, exec,      $doom
    bind = $mainMod, P, exec,      wayland-powermenu
    bind = $mainMod, B, exec,      wayland-websearch

    # Move focus with mainMod + hjkl
    bind = $mainMod, h, movefocus, l
    bind = $mainMod, j, movefocus, d
    bind = $mainMod, k, movefocus, u
    bind = $mainMod, l, movefocus, r

    # Resize with Ctrl + Mod + hjkl
    bind = $mainMod CTRL, h, resizeactive, -20 0
    bind = $mainMod CTRL, l, resizeactive,  20 0
    bind = $mainMod CTRL, k, resizeactive,  0  -20
    bind = $mainMod CTRL, j, resizeactive,  0  20

    # Swap windows with Shift + Mod + hjkl
    bind = $mainMod SHIFT, h, movewindow, l
    bind = $mainMod SHIFT, j, movewindow, d
    bind = $mainMod SHIFT, k, movewindow, u
    bind = $mainMod SHIFT, l, movewindow, r

    # Cycle through windows
    bind = $mainMod, W, cyclenext
    # bind = $mainMod, W, bringactivetotop

    # Toggle split windows
    bind = $mainMod, Space, togglesplit

    # Switch workspaces
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move window to workspace
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Special workspace (scratchpad)
    bind = $mainMod, S,        togglespecialworkspace, magic
    bind = $mainMod  SHIFT, S, movetoworkspace,        special:magic

    # Scroll through workspaces
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up,   workspace, e-1

    # Workspace navigation
    bind = $mainMod, backslash, workspace, previous
    bind = $mainMod, O, workspace, m+1
    bind = $mainMod, I, workspace, m-1

    # Mouse bindings
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    # Mouse mode with Super + Alt + hjkl
    binde = $mainMod CTRL, h, exec, ydotool mousemove -- -20 0   # Left
    binde = $mainMod CTRL, j, exec, ydotool mousemove -- 0 20    # Down
    binde = $mainMod CTRL, k, exec, ydotool mousemove -- 0 -20   # Up
    binde = $mainMod CTRL, l, exec, ydotool mousemove -- 20 0    # Right

    binde = $mainMod CTRL, COMMA, exec, ydotool click 0xC0       # Left click
    binde = $mainMod CTRL, PERIOD, exec, ydotool click 0xC1      # Right click

    # Diagonal directions
    binde = $mainMod CTRL, u, exec, ydotool mousemove -- -40 -40  # Up-Left
    binde = $mainMod CTRL, i, exec, ydotool mousemove -- 40 -40   # Up-Right
    binde = $mainMod CTRL, n, exec, ydotool mousemove -- -40 40   # Down-Left
    binde = $mainMod CTRL, m, exec, ydotool mousemove -- 40 40    # Down-Right

    # Move window to monitor
    bind = $mainMod SHIFT, PERIOD,  movewindow, mon:HDMI-A-1
    bind = $mainMod SHIFT, COMMA, movewindow,   mon:DVI-D-1

    # Monitor navigation
    bind = $mainMod, PERIOD,  focusmonitor, HDMI-A-1
    bind = $mainMod, COMMA, focusmonitor,   DVI-D-1

    # Swap workspaces between monitors
    bind = $mainMod CTRL, S, swapactiveworkspaces, DVI-D-1 HDMI-A-1 

    # Multimedia keys
    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

    # Media control
    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous

    # Screenshot
    bind = ,                    PRINT, exec, hyprshot -m output -m DVI-D-1
    bind = $shiftmainMod SHIFT, PRINT, exec, hyprshot -m output -m HDMI-A-1
  '';
}
