{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovide
    kakoune

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
