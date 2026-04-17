{ pkgs, ... }:

{
  imports = [
    ../kitty
    ../shell/fish
    ../helix
    ../emacs.nix
    ../neovim/astronvim.nix
    ../neovide
    ../tmux.nix
    ../vim.nix
    ../kakoune.nix
    ../git.nix
    ../yazi.nix

    ../android.nix
    ../dev-tools.nix
    ../ruby
    ../packages.nix
    ../shell/scripts.nix
    ../../scripts

    ../qtile
    ../i3
    ../dunst
    ../hyprland
    ../niri
    ../hyprpaper.nix
    ../waybar
    ../fuzzel.nix
    ../hyprlock.nix
    ../ydotool.nix
  ];

  home = {
    username = "nekomangini";
    homeDirectory = "/home/nekomangini";
    stateVersion = "25.05";
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "${pkgs.helix}/bin/hx";
    VISUAL = "${pkgs.helix}/bin/hx";
    TMUX_PATHS_FILE = "/run/agenix/tmux-manager-paths";
    NOTES_SECRET_FILE = "/run/agenix/note-path";
  };
}
