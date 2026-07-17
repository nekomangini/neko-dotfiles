{ pkgs, ... }:

let
  syncNotes = pkgs.writeShellApplication {
    name = "sync-notes";

    runtimeInputs = with pkgs; [
      rakudo
      git
    ];

    text = ''
      exec raku ${./notes.raku}
    '';
  };

  syncNekopaper = pkgs.writeShellApplication {
    name = "sync-nekopaper";

    runtimeInputs = with pkgs; [
      rakudo
      git
    ];

    text = ''
      exec raku ${./nekopaper.raku}
    '';
  };

  syncBlog = pkgs.writeShellApplication {
    name = "sync-blog";

    runtimeInputs = with pkgs; [
      rakudo
      git
    ];

    text = ''
      exec raku ${./blog.raku}
    '';
  };

  syncManager = pkgs.writeShellApplication {
    name = "esync";

    runtimeInputs = with pkgs; [
      rakudo
      fzf
      git
    ];

    text = ''
      exec raku ${./manager.raku}
    '';
  };
in

{
  home.packages = [
    syncNotes
    syncNekopaper
    syncBlog
    syncManager
  ];
}
