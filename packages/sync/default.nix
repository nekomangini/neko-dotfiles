{ pkgs, ... }:

let
  syncNotes = pkgs.writeShellApplication {
    name = "sync-notes";

    runtimeInputs = with pkgs; [
      rakudo
    ];

    text = ''
      exec raku ${./notes.raku}
    '';
  };

  syncNekopaper = pkgs.writeShellApplication {
    name = "sync-nekopaper";

    runtimeInputs = with pkgs; [
      rakudo
    ];

    text = ''
      exec raku ${./nekopaper.raku}
    '';
  };
in

{
  home.packages = [
    syncNotes
    syncNekopaper
  ];
}
