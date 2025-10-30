{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    # ENVIRONMENT VARIABLES
    env = XCURSOR_SIZE,24
    env = HYPRCURSOR_SIZE,24
    env = YDOTOOL_SOCKET,/tmp/ydotools
  '';
}
