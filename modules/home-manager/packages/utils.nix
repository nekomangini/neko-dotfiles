{ pkgs, ... }:

{
  home.packages = with pkgs; [
    i3lock-color
    wlr-randr
    feh
    scrot
    hyprshot
  ];
}
