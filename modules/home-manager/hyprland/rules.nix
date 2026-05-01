{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''

    # 1. Left Monitor: DP-1
    # Position starts at 0x0
    monitor=DP-1, 1920x1080@60, 0x0, 1

    # 2. Middle Monitor: DVI-D-1
    # Position starts at 1920x0 (Offset by the width of DP-1)
    monitor=DVI-D-1, 1920x1080@60, 1920x0, 1

    # 3. Right Monitor: HDMI-A-1
    # Position starts at 3840x0 (1920 + 1920)
    monitor=HDMI-A-1, 1920x1080@60, 3840x0, 1, transform, 3

    # WINDOW RULES
    windowrule = suppressevent maximize, class:.*
    windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

    # No blur for performance
    windowrule = opaque, noblur, class:^(vivaldi-stable)$
    windowrule = opaque, noblur, class:^(brave-browser)$
    windowrule = opaque, noblur, class:^(obsidian)$
    windowrule = opaque, noblur, class:^(org.kde.gwenview)$
    windowrule = opaque, noblur, class:^(org.kde.okular)$
    windowrule = opaque, noblur, class:^(org.kde.dolphin)$
    windowrule = opaque, noblur, class:^(krita)$
    windowrule = opaque, noblur, class:^(Logseq)$
    windowrule = opaque, noblur, class:^(Joplin)$
    windowrule = opaque, noblur, class:^(blender)$
    windowrule = opaque, noblur, class:^(Godot)$
    windowrule = opaque, noblur, class:^(jetbrains-studio)$
    windowrule = opaque, noblur, class:^(dev.zed.Zed)$
    windowrule = opaque, noblur, class:^(org.pwmt.zathura)
    windowrule = opaque, noblur, class:^(ticktick)

    # Override opacity
    windowrule = opacity 0.9 override 0.8 override 0.8 override, class:^(Emacs)$ # 0.9 active, 0.8 inactive, 0.8 fullscreen opacity
    windowrule = opacity 0.9 override 0.8 override 0.9 override, class:^(kitty)$ 

    # Window behavior
    windowrule = maximize,   class:^(Joplin)$
    windowrule = maximize,   class:^(brave-browser)$
    windowrule = maximize,   class:^(superProductivity)$
    windowrule = fullscreen, class:^(krita)$
    windowrule = fullscreen, class:^(blender)$
    windowrule = fullscreen, class:^(Godot)$
    windowrule = fullscreen, class:^(dev.zed.Zed)$
    windowrule = fullscreen, class:^(Joplin)$

    # Workspace assignments
    # monitor 32' (DP)
    windowrule = workspace 1,  class:brave-browser
    windowrule = workspace 2,  class:org.kde.gwenview
    windowrule = workspace 3,  class:org.pwmt.zathura
    windowrule = workspace 4,  class:Godot
    windowrule = workspace 5,  class:blender

    # monitor 22' (DVI)
    windowrule = group, workspace 6,  class:gimp-3.0
    windowrule = group, workspace 6,  class:krita
    windowrule = group, workspace 7,  class:obsidian
    windowrule = group, workspace 7,  class:Logseq
    windowrule = group, workspace 7,  class:Joplin
    windowrule = group, workspace 8,  class:vivaldi-stable
    windowrule = group, workspace 8,  class:org.kde.dolphin
    windowrule = group, workspace 8,  class:ticktick

    # monitor 22' (HDMI)
    windowrule = group, workspace 9,  class:org.kde.okular
    windowrule = group, workspace 9,  class:kitty
    windowrule = group, workspace 9,  class:Emacs
    windowrule = group, workspace 0,  class:dev.zed.Zed
    windowrule = group, workspace 0,  class:jetbrains-studio

    # Multi-monitor setup
    workspace = 1,  monitor:DP-1
    workspace = 2,  monitor:DP-1
    workspace = 3,  monitor:DP-1
    workspace = 4,  monitor:DP-1
    workspace = 5,  monitor:DP-1
    workspace = 6,  monitor:DVI-D-1
    workspace = 7,  monitor:DVI-D-1
    workspace = 8,  monitor:DVI-D-1
    workspace = 9,  monitor:HDMI-A-1
    workspace = 10, monitor:HDMI-A-1
  '';
}
