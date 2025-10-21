{ ... }:

{
  imports = [
    ../modules/home-manager/helix.nix
    ../modules/home-manager/fish.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/kitty.nix
    ../modules/home-manager/yazi.nix
    ../modules/home-manager/notes.nix
    ../modules/home-manager/scripts.nix
    ../modules/home-manager/packages.nix
    ../modules/home-manager/desktop.nix
    ../modules/home-manager/emacs.nix
  ];

  home.username = "nekomangini";
  home.homeDirectory = "/home/nekomangini";
  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
