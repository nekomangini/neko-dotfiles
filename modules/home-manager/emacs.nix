{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    shellcheck
    pandoc
    sbcl
  ];

  # emacs daemon server
  services.emacs = with pkgs; {
    enable = true;
    package = emacs-gtk;
  };

  programs.emacs = with pkgs; {
    enable = true;
    package = emacs-gtk;
  };

  home.sessionVariables = {
    EMACS_BIN_PATH = "${config.home.homeDirectory}/.config/emacs/bin";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];
}
