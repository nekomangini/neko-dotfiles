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
    resvg
    xclip
    wl-clipboard
    fastfetch
  ];
}
