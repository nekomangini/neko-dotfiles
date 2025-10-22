{ pkgs, ... }:

let
  sync-notes-script = ../scripts/sync-notes.raku;
  nlog-script = ../scripts/nlog.raku;
in
{
  home.packages = with pkgs; [
    (writeShellScriptBin "et" ''
      exec ${emacs-gtk}/bin/emacsclient -nw -c
    '')

    (writeShellScriptBin "helix-joplin" ''
      COMMAND_ARRAY=("${helix}/bin/hx" "$@")
      exec ${kitty}/bin/kitty ${tmux}/bin/tmux new-session -A -s joplin "''${COMMAND_ARRAY[@]}"
    '')

    (writeShellApplication {
      name = "sync-notes";
      runtimeInputs = [ rakudo ];
      text = ''
        exec ${rakudo}/bin/raku ${sync-notes-script} "$@"
      '';
    })

    (writeShellApplication {
      name = "dev-notes";
      runtimeInputs = [ rakudo ];
      text = ''
        exec ${rakudo}/bin/raku ${nlog-script} "$@"
      '';
    })
  ];
}
