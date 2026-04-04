{ pkgs, ... }:

let
  nlog-script = ../../scripts/nlog.raku;
  tmux-rails = ../../scripts/tmux-rails.raku;
  # webSearchScriptLoc = ../../scripts/fuzzel-websearch.raku;
in

{
  home.packages = with pkgs; [
    # ===== Emacs =====
    (writeShellScriptBin "ed" ''
      exec ${emacs}/bin/emacsclient -nw
    '')

    # ===== Wayland =====
    # TEST
    # (writeShellScriptBin "hed" ''
    #   exec ${emacs-pgtk}/bin/emacsclient -nw
    # '')
    # Imported in hyprland/keybinds.nix

    # ===== X11 =====

    # ===== Scripts=====
    # FIX script
    (writeShellApplication {
      name = "dev-notes";
      runtimeInputs = [ rakudo ];
      text = ''
        exec ${rakudo}/bin/raku ${nlog-script} "$@"
      '';
    })

    # TODO
    # (writeShellScriptBin "websearch" ''
    #   exec ${rakudo}/bin/raku ${webSearchScriptLoc}
    # '')

    # tmux
    (writeShellApplication {
      name = "tmuxrails";
      runtimeInputs = [ rakudo ];
      text = ''
        ${rakudo}/bin/raku ${tmux-rails}
      '';
    })

    # Joplin
    (writeShellScriptBin "helix-joplin" ''
      COMMAND_ARRAY=("${helix}/bin/hx" "$@")
      exec ${kitty}/bin/kitty ${tmux}/bin/tmux new-session -A -s joplin "''${COMMAND_ARRAY[@]}"
    '')

    # ===== AUTOMATION =====
  ];
}
