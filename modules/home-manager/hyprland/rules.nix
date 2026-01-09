{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''

    # Left Monitor: HDMI-A-1 (Width: 1360)
    monitor=HDMI-A-1, 1360x768, 0x0, 1

    # Middle Monitor: DP-1 (Starts after HDMI: 1360)
    monitor=DP-1, 1366x768, 1360x0, 1

    # Right Monitor: DVI-D-1 (Starts after HDMI+DP: 1360 + 1366 = 2726)
    monitor=DVI-D-1, 1920x1080, 2726x0, 1

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
    windowrule = opaque, noblur, class:^(jetbrains-studio)$
    windowrule = opaque, noblur, class:^(dev.zed.Zed)$

    # Override opacity
    windowrule = opacity 0.7 override 0.5 override, class:^(Emacs)$

    # Window behavior
    windowrule = maximize, class:^(Godot)$
    windowrule = maximize, class:^(libresprite)$
    windowrule = fullscreen, class:^(kitty)$
    windowrule = fullscreen, class:^(blender)$
    windowrule = fullscreen, class:^(Emacs)$
    windowrule = fullscreen, class:^(jetbrains-studio)$
    windowrule = fullscreen, class:^(krita)$

    # Workspace assignments
    # monitor 32' (HDMI)
    windowrule = workspace 1,  class:brave-browser
    windowrule = workspace 4,  class:obsidian
    windowrule = workspace 4,  class:Logseq
    windowrule = workspace 7,  class:gimp-3.0
    windowrule = workspace 7,  class:krita
    windowrule = workspace 7,  class:libresprite
    windowrule = workspace 10, class:Houdini FX
    windowrule = workspace 10, class:Godot
    windowrule = workspace 10, class:com.defold.editor.Start

    # monitor 19' (DP-1)
    windowrule = workspace 2,  class:vivaldi-stable
    windowrule = workspace 5,  class:org.kde.dolphin
    windowrule = workspace 8,  class:Joplin
    windowrule = workspace 8,  class:ticktick
    windowrule = workspace 8,  class:AppFlowy

    # monitor 22' (DVI-D-1)
    windowrule = workspace 3,  class:kitty
    windowrule = workspace 3,  class:Emacs
    windowrule = workspace 3,  class:dev.zed.Zed
    windowrule = workspace 3,  class:jetbrains-studio
    windowrule = workspace 6,  class:org.kde.okular
    windowrule = workspace 6,  class:org.kde.gwenview
    windowrule = workspace 9,  class:blender

    # Multi-monitor setup
    workspace = 1,  monitor:HDMI-A-1
    workspace = 2,  monitor:DP-1
    workspace = 3,  monitor:DVI-D-1
    workspace = 4,  monitor:HDMI-A-1
    workspace = 5,  monitor:DP-1
    workspace = 6,  monitor:DVI-D-1
    workspace = 7,  monitor:HDMI-A-1
    workspace = 8,  monitor:DP-1
    workspace = 9,  monitor:DVI-D-1
    workspace = 10, monitor:HDMI-A-1
  '';
}
