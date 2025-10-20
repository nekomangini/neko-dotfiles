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
      set -euo pipefail
      REPO_PATH="/run/media/nekomangini/D/emacs-save-files/emacs-org-sync"
      COMMIT_MESSAGE="update notes $(date +%m-%d-%Y)"
      if ! cd "$REPO_PATH"; then
        echo "ERROR: Could not find or access repository at $REPO_PATH" >&2
        exit 1
      fi
      git add .
      if git commit -m "$COMMIT_MESSAGE"; then
        echo "SUCCESS: Changes committed."
      else
        if [ $? -eq 1 ]; then
          echo "INFO: No changes detected. Skipping commit."
        else
          echo "ERROR: Git commit failed." >&2
          exit 1
        fi
      fi
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
    (writeShellScriptBin "qlog" ''
      #!/usr/bin/env bash
      exec /run/media/nekomangini/D/Programming/scripts/nlog.raku "$@"
    '')
  ];
}
