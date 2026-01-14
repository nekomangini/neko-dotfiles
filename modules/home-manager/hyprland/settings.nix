{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    # MONITORS
    # monitor=,preferred,auto,auto

    # LOOK AND FEEL
    general {
        gaps_in = 4
        gaps_out = 10
        border_size = 2
        col.active_border = rgba(A7C080ee) rgba(83C092ee) 45deg
        col.inactive_border = rgba(4F5B58aa)
        resize_on_border = false
        allow_tearing = false
        layout = dwindle
    }

    decoration {
        rounding = 0
        rounding_power = 0
        active_opacity     = 0.91
        inactive_opacity   = 0.7
        fullscreen_opacity = 1.0

        shadow {
            enabled = true
            range = 4
            render_power = 3
            color = rgba(1a1a1aee)
        }

        blur {
            enabled = true
            size = 1
            passes = 2
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

    device {
        name = epic-mouse-v1
        sensitivity = -0.5
    }
  '';
}
