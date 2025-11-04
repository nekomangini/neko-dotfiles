{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # X11/Window manager tools (qtile)
    picom
    rofi
    feh
  ];
}
