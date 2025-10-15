{ pkgs, ... }:

{
  imports = [
    ./modules/helix.nix
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/yazi.nix
    ./modules/notes.nix
  ];

  home.username = "nekomangini";
  home.homeDirectory = "/home/nekomangini";
  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # User-specific packages
  home.packages = with pkgs; [
    # Scripts
    (writeShellScriptBin "et" ''
      #!/usr/bin/env bash
      emacsclient -nw -s nekoserver
    '')

    neovide
    kakoune

    # CLI tools
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

    # X11/Window manager tools (qtile)
    dunst
    picom
    rofi
    feh
  ];
}
