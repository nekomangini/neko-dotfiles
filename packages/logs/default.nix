{ pkgs, ... }:

let
  nekomanginiDevLog = pkgs.writeShellApplication {
    name = "nlog";

    runtimeInputs = with pkgs; [
      rakudo
      fzf
    ];

    text = ''
      exec raku ${./nlog.raku}
    '';
  };
in

{
  home.packages = [
    nekomanginiDevLog
  ];
}
