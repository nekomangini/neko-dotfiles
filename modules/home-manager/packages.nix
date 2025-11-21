{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kakoune
    zed-editor

    discord

    vinegar
    godot

    # CLI
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    resvg
    xclip
    wl-clipboard
    eza
    fastfetch
    unzip

    # Notes
    logseq
    obsidian
    joplin-desktop
    ticktick
  ];
}
