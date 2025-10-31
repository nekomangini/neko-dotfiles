{ config, pkgs, ... }:

{
  imports = [
    ./alias.nix
    ./functions.nix
  ];

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      ${pkgs.zoxide}/bin/zoxide init fish | source
    '';
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];

  home.sessionVariables = {
    EMACS_BIN_PATH = "${config.home.homeDirectory}/.config/emacs/bin";
  };
}
