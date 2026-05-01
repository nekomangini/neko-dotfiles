{ pkgs, ... }:

{
  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = ${pkgs.waybar}/bin/waybar
    exec-once = /run/current-system/sw/libexec/polkit-kde-authentication-agent-1
    exec-once = ${pkgs.hyprpaper}/bin/hyprpaper

    exec-once = ${pkgs.kitty}/bin/kitty
    exec-once = ${pkgs.ticktick}/bin/ticktick
    exec-once = sleep 5 && ${pkgs.kdePackages.dolphin}/bin/dolphin
    exec-once = sleep 7 && ${pkgs.vivaldi}/bin/vivaldi
  '';
}
