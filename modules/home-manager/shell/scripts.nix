{ pkgs, ... }:

let
  sync-notes-script = ../../scripts/sync-notes.raku;
  sync-nekopaper-script = ../../scripts/sync-nekopaper.raku;
  nlog-script = ../../scripts/nlog.raku;
  powermenu = ../../scripts/powermenu.raku;
  helix-fzf = ../../scripts/helix-fzf.raku;
  tmux-rails = ../../scripts/tmux-rails.raku;
  helix-findword = ../../scripts/helix-findword.raku;
  webSearchScriptLoc = ../../scripts/fuzzel-websearch.raku;
  x11-screenshot = ../../scripts/x11-screenshot.raku;
  x11-powermenu = ../../scripts/x11-powermenu.raku;

in

{
  home.packages = with pkgs; [
    # Emacs
    (writeShellScriptBin "ed" ''
      exec ${emacs-gtk}/bin/emacsclient -nw
    '')
    (writeShellScriptBin "et" ''
      exec ${emacs-gtk}/bin/emacs -nw
    '')
    (pkgs.writeShellScriptBin "eg" ''
      ${pkgs.emacs-gtk}/bin/emacsclient -c -a ""
    '')

    (writeShellApplication {
      name = "dev-notes";
      runtimeInputs = [ rakudo ];
      text = ''
        exec ${rakudo}/bin/raku ${nlog-script} "$@"
      '';
    })

    (writeShellApplication {
      name = "hf";
      runtimeInputs = [ rakudo ];
      text = ''
        ${rakudo}/bin/raku ${helix-fzf}
      '';
    })

    (writeShellApplication {
      name = "tmuxrails";
      runtimeInputs = [ rakudo ];
      text = ''
        ${rakudo}/bin/raku ${tmux-rails}
      '';
    })

    (writeShellApplication {
      name = "hw";
      runtimeInputs = [ rakudo ];
      text = ''
        exec ${rakudo}/bin/raku ${helix-findword} "$@"
      '';
    })

    # Joplin app
    (writeShellScriptBin "helix-joplin" ''
      COMMAND_ARRAY=("${helix}/bin/hx" "$@")
      exec ${kitty}/bin/kitty ${tmux}/bin/tmux new-session -A -s joplin "''${COMMAND_ARRAY[@]}"
    '')

    # Imported in hyprland/keybinds.nix
    (writeShellApplication {
      name = "powermenu";
      runtimeInputs = [ rakudo ];
      text = ''
        ${rakudo}/bin/raku ${powermenu}
      '';
    })

    # Imported in i3/keybinds.nix
    (writeShellApplication {
      name = "x11screenshot";
      runtimeInputs = [ rakudo ];
      text = ''
        ${rakudo}/bin/raku ${x11-screenshot} "$@"
      '';
    })
    (writeShellApplication {
      name = "x11powermenu";
      runtimeInputs = [ rakudo ];
      text = ''
        ${rakudo}/bin/raku ${x11-powermenu}
      '';
    })

    (writeShellScriptBin "websearch" ''
      exec ${rakudo}/bin/raku ${webSearchScriptLoc}
    '')

    (writeShellApplication {
      name = "sync-notes";
      runtimeInputs = [ rakudo ];
      text = ''
        exec ${rakudo}/bin/raku ${sync-notes-script}
      '';
    })

    (writeShellApplication {
      name = "sync-nekopaper";
      runtimeInputs = [ rakudo ];
      text = ''exec ${rakudo}/bin/raku ${sync-nekopaper-script}'';
    })
  ];
}
