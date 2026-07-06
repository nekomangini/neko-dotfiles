{ pkgs, ... }:

let
  waylandPowermenu = pkgs.writeShellApplication {
    name = "wayland-powermenu";

    runtimeInputs = with pkgs; [
      rakudo
      fuzzel
    ];

    text = ''
      exec raku ${./wayland.raku}
    '';
  };

  x11Powermenu = pkgs.writeShellApplication {
    name = "x-powermenu";

    runtimeInputs = with pkgs; [
      rakudo
      rofi
    ];

    text = ''
      exec raku ${./x11.raku}
    '';
  };
in

{
  home.packages = [
    waylandPowermenu
    x11Powermenu
  ];
}
