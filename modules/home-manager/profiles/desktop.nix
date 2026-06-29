{ config, ... }:

{
  imports = [
    ../kitty
    ../shell
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
    ../../scripts
    ../kdeconnect.nix

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

  # ndir path
  myModules.ndir.directories = [
    "/home/nekomangini/neko-dotfiles"
    "/mnt/D/Programming/android-projects"
    "/mnt/D/Programming/Projects"
    "/mnt/D/Programming/dotfiles"
    "/mnt/D/Programming/blender-python"
    "/mnt/D/Programming/scripts"
    "/mnt/D/Programming/programming-exercises"
    "/mnt/D/emacs-org-sync"
    "/mnt/D/game-development/save-files"
    "${config.home.homeDirectory}/.config/nekovim"
    "${config.home.homeDirectory}/.config/astronvim-v5"
  ];

  home = {
    username = "nekomangini";
    homeDirectory = "/home/nekomangini";
    stateVersion = "26.05";
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  home.sessionVariables = {
    # EDITOR = "${pkgs.helix}/bin/hx";
    # VISUAL = "${pkgs.helix}/bin/hx";
    TMUX_PATHS_FILE = "/run/agenix/tmux-manager-paths";
    NOTES_SECRET_FILE = "/run/agenix/note-path";
  };

  # NOTE Only add this if you ever need pure X11 emacs:
  # myModules.emacs.package = pkgs.emacs-gtk;
}
