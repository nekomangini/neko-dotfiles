{ pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    libreoffice
    zathura
    planify
    obsidian
    joplin-desktop
    brave
    vivaldi
  ];
}
