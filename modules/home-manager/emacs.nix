{ config, pkgs, ... }:

{
  # emacs daemon server
  services.emacs = with pkgs; {
    enable = true;
    startWithUserSession = "graphical";
    # extraOptions = [ "-D" ];
    # extraOptions = [ "-l" "~/.config/emacs/init.el" ];
    package = (
      emacs-gtk.pkgs.withPackages (epkgs: [
        epkgs.treesit-grammars.with-all-grammars
      ])
    );
  };

  programs.emacs = with pkgs; {
    enable = true;
    package = (
      emacs-gtk.pkgs.withPackages (epkgs: [
        epkgs.treesit-grammars.with-all-grammars
      ])
    );
  };

  home.sessionVariables = {
    EMACS_BIN_PATH = "${config.home.homeDirectory}/.config/emacs/bin";
    DART_SDK = "${pkgs.dart}";
    FLUTTER_ROOT = "${pkgs.flutter}";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];
}
