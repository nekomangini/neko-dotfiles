{ pkgs, ... }:

{
  imports = [
    ./editor.nix
    ./languages.nix
    ./servers.nix
  ];

  programs.helix.enable = true;
  home.sessionVariables = {
    EDITOR = "${pkgs.helix}/bin/hx";
    VISUAL = "${pkgs.helix}/bin/hx";
  };
}
