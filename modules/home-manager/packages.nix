{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kakoune
    zed-editor

    discord
    libreoffice

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
    woeusb
    htop

    # Notes
    logseq
    obsidian
    joplin-desktop
    ticktick
  ];
}
