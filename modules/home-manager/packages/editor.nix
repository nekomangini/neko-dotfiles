{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    zed-editor
    vimgolf
  ];
}
