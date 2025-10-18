{ ... }:

{
  imports = [
    ./modules/helix.nix
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/yazi.nix
    ./modules/notes.nix
    ./modules/scripts.nix
    ./modules/packages.nix
    ./modules/desktop.nix
  ];

  home.username = "nekomangini";
  home.homeDirectory = "/home/nekomangini";
  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
