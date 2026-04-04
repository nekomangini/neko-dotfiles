{ pkgs, ... }:

{
  imports = [
    ../helix
    ../neovim/astronvim.nix
    ../neovide
    ../qtile
    ../i3
    ../shell/fish
    ../dunst
    ../shell/scripts.nix
    ../../../modules/scripts/tmux-manager.nix
    ../../../modules/scripts/helix-findword.nix
    ../../../modules/scripts/helix-fzf.nix
    ../../../modules/scripts/x11-powermenu.nix
    ../../../modules/scripts/x11-screenshot.nix
    ../../../modules/scripts/x11-websearch.nix
    ../../../modules/scripts/sync-notes.nix
    ../../../modules/scripts/sync-nekopaper.nix
    ../../../modules/scripts/wayland-powermenu.nix
    ../../../modules/scripts/wayland-websearch.nix
    ../git.nix
    ../kitty
    ../yazi.nix
    ../packages.nix
    ../emacs.nix
    ../hyprland
    ../niri
    ../hyprpaper.nix
    ../waybar
    ../fuzzel.nix
    ../hyprlock.nix
    ../ydotool.nix
    ../android.nix
    ../ruby
    ../tmux.nix
    ../vim.nix
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
