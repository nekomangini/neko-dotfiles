{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kakoune
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

    # Notes
    logseq
    obsidian
    joplin-desktop
  ];
}
