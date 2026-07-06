{ pkgs, ... }:

let
  waylandWebSearch = pkgs.writeShellApplication {
    name = "wayland-websearch";

    runtimeInputs = with pkgs; [
      rakudo
      fuzzel
      vivaldi
    ];

    text = ''
      exec raku ${./wayland.raku}
    '';
  };

  x11WebSearch = pkgs.writeShellApplication {
    name = "x11-websearch";

    runtimeInputs = with pkgs; [
      rakudo
      rofi
      vivaldi
    ];

    text = ''
      exec raku ${./x11.raku}
    '';
  };
in

{
  home.packages = [
    waylandWebSearch
    x11WebSearch
  ];
}
