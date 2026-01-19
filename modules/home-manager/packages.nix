{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kakoune
    zed-editor

    discord
    libreoffice
    fancontrol-gui
    zathura
    affine

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
    lm_sensors
    wlr-randr

    # Notes
    logseq
    obsidian
    joplin-desktop
    ticktick
  ];
}
