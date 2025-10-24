{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    extraConfig = ''
      # MONITORS
      monitor=,preferred,auto,auto

      # MY PROGRAMS
      $terminal = kitty
      $tmux = kitty -e tmux new-session -A -s main
      $fileManager = dolphin
      $doom = emacsclient -c
      $menu = wofi --show drun

      # AUTOSTART
      exec-once = waybar
      exec-once = /run/current-system/sw/libexec/polkit-kde-authentication-agent-1
      exec-once = hyprpaper

      # ENVIRONMENT VARIABLES
      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24

      # LOOK AND FEEL
      general {
          gaps_in = 4
          gaps_out = 10
          border_size = 1
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          resize_on_border = false
          allow_tearing = false
          layout = dwindle
      }

      decoration {
          rounding = 5
          rounding_power = 5
          active_opacity     = 0.8
          inactive_opacity   = 0.5
          fullscreen_opacity = 0.7

          shadow {
              enabled = true
              range = 4
              render_power = 3
              color = rgba(1a1a1aee)
          }

          blur {
              enabled = true
              size = 3
              passes = 4
              vibrancy = 0.1696
          }
      }

      animations {
          enabled = true

          bezier = easeOutQuint,0.23,1,0.32,1
          bezier = easeInOutCubic,0.65,0.05,0.36,1
          bezier = linear,0,0,1,1
          bezier = almostLinear,0.5,0.5,0.75,1.0
          bezier = quick,0.15,0,0.1,1

          animation = global, 1, 10, default
          animation = border, 1, 5.39, easeOutQuint
          animation = windows, 1, 4.79, easeOutQuint
          animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
          animation = windowsOut, 1, 1.49, linear, popin 87%
          animation = fadeIn, 1, 1.73, almostLinear
          animation = fadeOut, 1, 1.46, almostLinear
          animation = fade, 1, 3.03, quick
          animation = layers, 1, 3.81, easeOutQuint
          animation = layersIn, 1, 4, easeOutQuint, fade
          animation = layersOut, 1, 1.5, linear, fade
          animation = fadeLayersIn, 1, 1.79, almostLinear
          animation = fadeLayersOut, 1, 1.39, almostLinear
          animation = workspaces, 1, 1.94, almostLinear, fade
          animation = workspacesIn, 1, 1.21, almostLinear, fade
          animation = workspacesOut, 1, 1.94, almostLinear, fade
      }

      dwindle {
          pseudotile = true
          preserve_split = true
      }

      master {
          new_status = master
      }

      misc {
          force_default_wallpaper = -1
          disable_hyprland_logo = false
      }

      # INPUT
      input {
          kb_layout = us
          follow_mouse = 1
          sensitivity = 0

          touchpad {
              natural_scroll = false
          }
      }

      gestures {
          workspace_swipe = false
      }

      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }

      # KEYBINDINGS
      $mainMod = SUPER

      bind = $mainMod, P,            pseudo,
      bind = $mainMod, T,            togglesplit,
      bind = $mainMod, V,            togglefloating,
      bind = $mainMod, Q,            killactive,
      bind = $mainMod  CTRL, q,      exit,
      bind = $mainMod, RETURN,       exec, $terminal
      bind = $mainMod  CTRL, RETURN, exec, $tmux
      bind = $mainMod, D, exec,      $menu
      bind = $mainMod, E, exec,      $doom
      bind = $mainMod, F, fullscreen, 0

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
      bind = $mainMod, W, bringactivetotop

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
      bind = $mainMod, TAB,       workspace, previous
      bind = $mainMod, O, workspace, m+1
      bind = $mainMod, I, workspace, m-1

      # Mouse bindings
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Move window to monitor
      bind = $mainMod SHIFT, COMMA,  movewindow, mon:DVI-D-1
      bind = $mainMod SHIFT, PERIOD, movewindow, mon:HDMI-A-1

      # Monitor navigation
      bind = $mainMod, COMMA,  focusmonitor, DVI-D-1
      bind = $mainMod, PERIOD, focusmonitor, HDMI-A-1

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
      bind = ,                    PRINT, exec, hyprshot -m output -m HDMI-A-1
      bind = $shiftmainMod SHIFT, PRINT, exec, hyprshot -m output -m DVI-D-1

      # WINDOW RULES
      windowrule = suppressevent maximize, class:.*
      windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

      # No blur for performance
      windowrule = opaque, noblur, class:^(vivaldi-stable)$
      windowrule = opaque, noblur, class:^(zen)$
      windowrule = opaque, noblur, class:^(org.qutebrowser.qutebrowser)$
      windowrule = opaque, noblur, class:^(brave-browser)$
      windowrule = opaque, noblur, class:^(obsidian)$
      windowrule = opaque, noblur, class:^(AppFlowy)$
      windowrule = opaque, noblur, class:^(org.kde.gwenview)$
      windowrule = opaque, noblur, class:^(org.kde.okular)$
      windowrule = opaque, noblur, class:^(org.kde.dolphin)$
      windowrule = opaque, noblur, class:^(gimp-3.0)$
      windowrule = opaque, noblur, class:^(krita)$
      windowrule = opaque, noblur, class:^(libresprite)$
      windowrule = opaque, noblur, class:^(Logseq)$
      windowrule = opaque, noblur, class:^(Joplin)$
      windowrule = opaque, noblur, class:^(blender)$
      windowrule = opaque, noblur, class:^(Houdini FX)$
      windowrule = opaque, noblur, class:^(Godot)$
      windowrule = opaque, noblur, class:^(com.defold.editor.Start)$

      # Window behavior
      windowrule = maximize, class:^(Godot)$
      windowrule = maximize, class:^(libresprite)$
      windowrule = fullscreen, class:^(kitty)$
      windowrule = fullscreen, class:^(blender)$

      # Workspace assignments
      windowrule = workspace 1,  class:kitty
      windowrule = workspace 2,  class:zen
      windowrule = workspace 2,  class:org.qutebrowser.qutebrowser
      windowrule = workspace 2,  class:vivaldi-stable
      windowrule = workspace 3,  class:Emacs
      windowrule = workspace 4,  class:brave-browser
      windowrule = workspace 4,  class:org.kde.okular
      windowrule = workspace 4,  class:dev.zed.Zed
      windowrule = workspace 4,  class:jetbrains-clion
      windowrule = workspace 4,  class:jetbrains-idea-ce
      windowrule = workspace 4,  class:jetbrains-pycharm-ce
      windowrule = workspace 4,  class:jetbrains-studio
      windowrule = workspace 5,  class:ticktick
      windowrule = workspace 5,  class:AppFlowy
      windowrule = workspace 5,  class:obsidian
      windowrule = workspace 5,  class:Logseq
      windowrule = workspace 5,  class:Joplin
      windowrule = workspace 6,  class:org.kde.gwenview
      windowrule = workspace 6,  class:org.kde.dolphin
      windowrule = workspace 7,  class:blender
      windowrule = workspace 8,  class:Houdini FX
      windowrule = workspace 9,  class:gimp-3.0
      windowrule = workspace 9,  class:krita
      windowrule = workspace 9,  class:libresprite
      windowrule = workspace 10, class:Godot
      windowrule = workspace 10, class:com.defold.editor.Start

      # Multi-monitor setup
      workspace = 1,  monitor:DVI-D-1
      workspace = 2,  monitor:HDMI-A-1
      workspace = 3,  monitor:HDMI-A-1
      workspace = 4,  monitor:DVI-D-1
      workspace = 5,  monitor:HDMI-A-1
      workspace = 6,  monitor:DVI-D-1
      workspace = 7,  monitor:HDMI-A-1
      workspace = 8,  monitor:HDMI-A-1
      workspace = 9,  monitor:HDMI-A-1
      workspace = 10, monitor:HDMI-A-1
    '';
  };

  # Install Hyprland-related packages
  # home.packages = with pkgs; [
  #   walker
  # ];
}
