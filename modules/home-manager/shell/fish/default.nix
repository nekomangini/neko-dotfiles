{ config, pkgs, ... }:

{
  imports = [
    ./alias.nix
    ./functions.nix
    ./keybinds.nix
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      ${pkgs.zoxide}/bin/zoxide init fish | source
      fish_add_path $HOME/.local/state/Dart/install/bin
      fish_add_path $HOME/.pub-cache/bin
    '';
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];

  home.sessionVariables = {
    EMACS_BIN_PATH = "${config.home.homeDirectory}/.config/emacs/bin";
  };
}
