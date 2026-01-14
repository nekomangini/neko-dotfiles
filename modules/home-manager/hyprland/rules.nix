{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''

    # 1. Left Monitor (22"): HDMI-A-1
    monitor=HDMI-A-1, 1920x1080, 0x0, 1

    # 2. Right Monitor (22"): DVI-D-1
    monitor=DVI-D-1, 1920x1080, 1920x0, 1, transform, 3

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

    # Override opacity
    windowrule = opacity 0.9 override 0.8 override 0.94 override, class:^(Emacs)$ # 0.9 active, 0.5 inactive, 0.9 fullscreen opacity
    windowrule = opacity 0.9 override 0.8 override 0.9 override, class:^(kitty)$ 

    # Window behavior
    windowrule = maximize,   class:^(org.kde.okular)$
    windowrule = maximize,   class:^(org.kde.dolphin)$
    windowrule = maximize,   class:^(Joplin)$
    windowrule = maximize,   class:^(brave-browser)$
    windowrule = fullscreen, class:^(krita)$
    windowrule = fullscreen, class:^(blender)$
    windowrule = fullscreen, class:^(Godot)$
    windowrule = fullscreen, class:^(kitty)$
    windowrule = fullscreen, class:^(Emacs)$
    windowrule = fullscreen, class:^(jetbrains-studio)$
    windowrule = fullscreen, class:^(dev.zed.Zed)$
    windowrule = fullscreen, class:^(Logseq)$
    windowrule = fullscreen, class:^(Joplin)$
    windowrule = fullscreen, class:^(obsidian)$

    # Workspace assignments
    # monitor 22' (HDMI-A-1 LEFT) 
    windowrule = workspace 2,  class:vivaldi-stable
    windowrule = workspace 4,  class:org.kde.okular
    windowrule = workspace 4,  class:org.kde.gwenview
    windowrule = workspace 6,  class:org.kde.dolphin
    windowrule = workspace 6,  class:brave-browser
    windowrule = workspace 8,  class:blender
    windowrule = workspace 8,  class:krita
    windowrule = workspace 10, class:Godot


    # monitor 22' (DVI-D-1 RIGHT) Vertical
    windowrule = workspace 1,  class:kitty
    windowrule = workspace 3,  class:Emacs
    windowrule = workspace 3,  class:dev.zed.Zed
    windowrule = workspace 3,  class:jetbrains-studio
    windowrule = workspace 7,  class:Logseq
    windowrule = workspace 7,  class:Joplin
    windowrule = workspace 9,  class:ticktick
    windowrule = workspace 9,  class:obsidian

    # Multi-monitor setup
    workspace = 1,  monitor:DVI-D-1
    workspace = 2,  monitor:HDMI-A-1
    workspace = 3,  monitor:DVI-D-1
    workspace = 4,  monitor:HDMI-A-1
    workspace = 5,  monitor:DVI-D-1
    workspace = 6,  monitor:HDMI-A-1
    workspace = 7,  monitor:DVI-D-1
    workspace = 8,  monitor:HDMI-A-1
    workspace = 9,  monitor:DVI-D-1
    workspace = 10, monitor:HDMI-A-1
  '';
}
