{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovide
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

    # Notes
    logseq
    obsidian
    joplin-desktop
    ticktick
  ];
}
