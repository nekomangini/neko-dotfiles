{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Scripts
    (writeShellScriptBin "et" ''
      #!/usr/bin/env bash
      emacsclient -nw -c
    '')

    (writeShellScriptBin "helix-joplin" ''
      #!/usr/bin/env bash
      COMMAND_ARRAY=("hx" "$@")
      exec kitty tmux new-session -A -s joplin "''${COMMAND_ARRAY[@]}"
    '')
    (writeShellScriptBin "sync-notes" ''
      #!/usr/bin/env bash
      exec /run/media/nekomangini/D/Programming/scripts/sync-notes.raku "$@"
    '')
    (writeShellScriptBin "dev-notes" ''
      #!/usr/bin/env bash
      exec /run/media/nekomangini/D/Programming/scripts/nlog.raku "$@"
    '')
  ];
}
