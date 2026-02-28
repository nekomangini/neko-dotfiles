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
    super-productivity

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
  ];
}
