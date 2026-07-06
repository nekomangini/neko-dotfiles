{ pkgs, ... }:

let

  tmxManager = pkgs.writeShellApplication {
    name = "tmx";

    runtimeInputs = with pkgs; [
      rakudo
      fzf
      tmux
      kitty
    ];

    text = ''
      exec raku ${./manager.raku}
    '';
  };

  tmuxSessions = pkgs.writeShellApplication {
    name = "tmx-sessions";

    runtimeInputs = with pkgs; [
      rakudo
      fzf
      tmux
      kitty
    ];

    text = ''
      exec raku ${./sessions.raku}
    '';
  };

  tmuxRubyOnRails = pkgs.writeShellApplication {
    name = "tmx-rails";

    runtimeInputs = with pkgs; [
      rakudo
      tmux
      kitty
    ];

    text = ''
      exec raku ${./ruby-on-rails.raku}
    '';
  };
in

{
  home.packages = [
    tmxManager
    tmuxSessions
    tmuxRubyOnRails
  ];
}
