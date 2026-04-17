{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zed-editor
    vimgolf

    hugo
    zola

    discord
    libreoffice
    fancontrol-gui
    zathura
    appimage-run
    planify
    ticktick

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

    gemini-cli
    qwen-code

    xdotool
    feh
    scrot
    playerctl
    i3lock-color

    # Notes
    logseq
    obsidian
    joplin-desktop
  ];
}
