{ pkgs, ... }:
{
  home.packages = with pkgs; [
    logseq
    obsidian
    joplin-desktop
    appflowy
    ticktick
  ];
}
