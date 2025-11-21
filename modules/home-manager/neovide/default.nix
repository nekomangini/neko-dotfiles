{ pkgs, ... }:

{
  imports = [
    ./neovide.nix
  ];

  home.packages = with pkgs; [
    neovide
  ];
}
