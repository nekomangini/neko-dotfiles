{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''

    # 1. Left Monitor (19"): DP-1
    monitor=DP-1, 1366x768, 0x0, 1, transform, 3

    # TODO: Remove 30px bottom reservation if the DP-1 monitor is replaced.
    monitor=DP-1, addreserved,0,0,0,30

    # 2. Right Monitor (22"): DVI-D-1
    monitor=DVI-D-1, 1920x1080, 768x0, 1
    # monitor=DVI-D-1, addreserved,0,0,0,30

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
    windowrule = opaque, noblur, class:^(libresprite)$
    windowrule = opaque, noblur, class:^(Logseq)$
    windowrule = opaque, noblur, class:^(Joplin)$
    windowrule = opaque, noblur, class:^(blender)$
    windowrule = opaque, noblur, class:^(Godot)$
    windowrule = opaque, noblur, class:^(jetbrains-studio)$

    # Window behavior
    windowrule = maximize,   class:^(kitty)$
    windowrule = maximize,   class:^(org.kde.okular)$
    windowrule = maximize,   class:^(Emacs)$
    windowrule = maximize,   class:^(Joplin)$
    windowrule = fullscreen, class:^(jetbrains-studio)$
    windowrule = fullscreen, class:^(krita)$
    windowrule = fullscreen, class:^(blender)$
    windowrule = fullscreen, class:^(Godot)$

    # Workspace assignments
    # monitor 19' (DP-1) Vertical
    windowrule = workspace 1,  class:kitty
    windowrule = workspace 4,  class:Logseq
    windowrule = workspace 4,  class:org.kde.okular
    windowrule = workspace 4,  class:ticktick
    windowrule = workspace 4,  class:org.kde.gwenview


    # monitor 22' (DVI-D-1)
    windowrule = workspace 2,  class:vivaldi-stable
    windowrule = workspace 2,  class:brave-browser
    windowrule = workspace 3,  class:Emacs
    windowrule = workspace 3,  class:dev.zed.Zed
    windowrule = workspace 3,  class:jetbrains-studio
    windowrule = workspace 5,  class:obsidian
    windowrule = workspace 6,  class:Joplin
    windowrule = workspace 6,  class:org.kde.dolphin
    windowrule = workspace 7,  class:blender
    windowrule = workspace 9,  class:krita
    windowrule = workspace 10, class:Godot

    # Multi-monitor setup
    workspace = 1,  monitor:DP-1
    workspace = 2,  monitor:DVI-D-1
    workspace = 3,  monitor:DVI-D-1
    workspace = 4,  monitor:DP-1
    workspace = 5,  monitor:DVI-D-1
    workspace = 6,  monitor:DVI-D-1
    workspace = 7,  monitor:DVI-D-1
    workspace = 8,  monitor:DVI-D-1
    workspace = 9,  monitor:DVI-D-1
    workspace = 10, monitor:DVI-D-1
  '';
}
