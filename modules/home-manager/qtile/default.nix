{ ... }:

{
  home.file.".config/qtile" = {
    source = ./config;
    recursive = true;
  };

  imports = [
    ../rofi.nix
    ../picom.nix
  ];

}
