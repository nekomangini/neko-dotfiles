{ pkgs, ... }:

{
  home.file.".config/qtile" = {
    source = ./config;
    recursive = true;
  };

  imports = [
    ./rofi.nix
    ./picom.nix
  ];

  home.packages = with pkgs; [
    scrot
    playerctl
    feh
    xdotool
    i3lock-color
  ];
}
