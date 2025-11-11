{ pkgs, ... }:

{
  imports = [
    ../helix
    ../shell/fish
    ../dunst
    ../shell/scripts.nix
    ../git.nix
    ../kitty
    ../yazi.nix
    ../notes.nix
    ../packages.nix
    ../qtile.nix
    ../emacs.nix
    ../hyprland
    ../hyprpaper.nix
    ../waybar
    ../fuzzel.nix
    ../hyprlock.nix
    ../ydotool.nix
    ../android.nix
    ../ruby
  ];

  home = {
    username = "nekomangini";
    homeDirectory = "/home/nekomangini";
    stateVersion = "25.05";
  };
  # home.username = "nekomangini";
  # home.homeDirectory = "/home/nekomangini";
  # home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "${pkgs.helix}/bin/hx";
    VISUAL = "${pkgs.helix}/bin/hx";
  };
}
