{ config, pkgs, ... }:

{
  # Define a new attribute set to export note-related packages/scripts
  options.config.notesPackages = {
    enable = {
      type = pkgs.lib.types.bool;
      default = false;
      description = "Enable all note-taking apps and associated scripts.";
    };

    packages = {
      type = pkgs.lib.types.listOf pkgs.lib.types.package;
      default = [ ];
      description = "List of note-taking packages and scripts.";
    };
  };

  # Define the actual packages/scripts if enabled
  config = pkgs.lib.mkIf config.notesPackages.enable {
    notesPackages.packages = with pkgs; [
      # Note-taking applications
      logseq
      obsidian
      joplin-desktop
      appflowy
      ticktick

      # Note-related scripts (Moved from home.packages)
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
    ];
  };
}
