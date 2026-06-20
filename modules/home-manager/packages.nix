{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zed-editor
    vimgolf

    hugo
    zola

    discord
    libreoffice
    zathura
    appimage-run
    planify

    # Music
    easytag
    picard

    godot

    # CLI
    fd
    ripgrep
    fzf
    zoxide
    eza
    fastfetch
    htop

    xclip
    wl-clipboard
    wlr-randr

    jq
    poppler
    resvg
    unzip
    woeusb
    lm_sensors

    qwen-code

    xdotool
    feh
    scrot
    playerctl
    i3lock-color

    # Notes
    obsidian
    joplin-desktop
  ];
}
