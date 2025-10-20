{ pkgs, ... }:

{
  home.packages = with pkgs; [
    discord

    # X11/Window manager tools (qtile)
    dunst
    picom
    rofi
    feh
  ];
}
