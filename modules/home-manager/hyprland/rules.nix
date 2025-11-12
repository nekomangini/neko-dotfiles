{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
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

    # Window behavior
    windowrule = maximize, class:^(Godot)$
    windowrule = maximize, class:^(libresprite)$
    windowrule = fullscreen, class:^(kitty)$
    windowrule = fullscreen, class:^(blender)$
    windowrule = fullscreen, class:^(Emacs)$
    windowrule = fullscreen, class:^(jetbrains-studio)$
    windowrule = fullscreen, class:^(krita)$

    # Workspace assignments
    windowrule = workspace 1,  class:kitty
    windowrule = workspace 2,  class:vivaldi-stable
    windowrule = workspace 2,  class:brave-browser
    windowrule = workspace 3,  class:Emacs
    windowrule = workspace 3,  class:dev.zed.Zed
    windowrule = workspace 3,  class:jetbrains-studio
    windowrule = workspace 4,  class:org.kde.okular
    windowrule = workspace 4,  class:obsidian
    windowrule = workspace 5,  class:ticktick
    windowrule = workspace 5,  class:AppFlowy
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
  '';
}
