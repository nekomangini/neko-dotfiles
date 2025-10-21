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
      DIR="/run/media/nekomangini/D/logseq-files/journals/"
      FILENAME="$(date +%Y_%m_%d).org"
      FULLPATH="$DIR/$FILENAME"
      cat <<EOF >>"$FULLPATH"
      * Learning [[ Topic ]]
      ** Practiced:
        - a
      ** Key insight:
        - a
      ** Code snippet:
        #+BEGIN_SRC
        #+END_SRC
      ** Apply to:
        - a
      ** Todo for tomorrow:
        - a
      EOF
      emacsclient -c -s 'nekoserver' "$FULLPATH"
    '')
    (writeShellScriptBin "dev-notes" ''
      #!/usr/bin/env bash
      exec /run/media/nekomangini/D/Programming/scripts/nlog.raku "$@"
    '')
  ];
}
