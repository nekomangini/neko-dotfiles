{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    # AUTOSTART
    exec-once = waybar
    exec-once = /run/current-system/sw/libexec/polkit-kde-authentication-agent-1
    exec-once = hyprpaper
  '';
}
