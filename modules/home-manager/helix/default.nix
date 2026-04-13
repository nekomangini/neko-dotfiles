{ ... }:

{
  imports = [
    ./editor.nix
    ./languages.nix
    ./servers.nix
  ];

  programs.helix.enable = true;
}
