{ pkgs, ... }:
{
  # emacs daemon server
  services.emacs = with pkgs; {
    enable = true;
    package = emacs-gtk;
  };

  programs.emacs = with pkgs; {
    enable = true;
    package = emacs-gtk;
  };
}
