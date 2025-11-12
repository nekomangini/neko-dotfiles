{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovide
    kakoune

    discord

    vinegar

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
  ];
}
