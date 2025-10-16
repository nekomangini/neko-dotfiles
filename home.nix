{ pkgs, ... }:

{
  imports = [
    ./modules/helix.nix
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/yazi.nix
    ./modules/notes.nix
  ];

  home.username = "nekomangini";
  home.homeDirectory = "/home/nekomangini";
  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # User-specific packages
  home.packages = with pkgs; [
    # Scripts
    (writeShellScriptBin "et" ''
      #!/usr/bin/env bash
      emacsclient -nw -s nekoserver
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

    neovide
    kakoune

    # CLI tools
    jq
    poppler
    fd
    ripgrep
    fzf
    zoxide
    resvg
    xclip
    wl-clipboard
    eza
    fastfetch

    # X11/Window manager tools (qtile)
    dunst
    picom
    rofi
    feh
  ];
}
