{ pkgs, ... }:

let
  hyprlandPowermenu = pkgs.writeShellApplication {
    name = "hyprland-powermenu";

    runtimeInputs = with pkgs; [
      rakudo
      fuzzel
    ];

    text = ''
      exec raku ${./hyprland.raku}
    '';
  };

  niriPowermenu = pkgs.writeShellApplication {
    name = "niri-powermenu";

    runtimeInputs = with pkgs; [
      rakudo
      fuzzel
    ];

    text = ''
      exec raku ${./niri.raku}
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
    hyprlandPowermenu
    niriPowermenu
    x11Powermenu
  ];
}
