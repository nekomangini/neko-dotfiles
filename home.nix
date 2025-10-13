{ pkgs, ... }:

{
  imports = [
    ./modules/helix.nix
    ./modules/fish.nix
    ./modules/git.nix
  ];

  home.username = "nekomangini";
  home.homeDirectory = "/home/nekomangini";
  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "e" ];
          run = ''shell "hx $@" --block --confirm'';
          desc = "Edit with Helix";
        }
      ];
    };
  };

  programs.kitty = {
    enable = true;
    # Optional: Add any other settings (e.g., font, theme)
    # font.size = 12.0;
  };

  # User-specific packages
  home.packages = with pkgs; [
    # Scripts
    (writeShellScriptBin "helix-joplin" ''
      #!/usr/bin/env bash
      COMMAND_ARRAY=("hx" "$@")
      exec kitty tmux new-session -A -s joplin "''${COMMAND_ARRAY[@]}"
    '')
    (writeShellScriptBin "sync-notes" ''
      #!/usr/bin/env bash
      # Use set -euo pipefail for maximum safety
      set -euo pipefail

      REPO_PATH="/run/media/nekomangini/D/emacs-save-files/emacs-org-sync"
      COMMIT_MESSAGE="update notes $(date +%m-%d-%Y)"

      # 1. Change directory and handle failure explicitly
      if ! cd "$REPO_PATH"; then
        echo "ERROR: Could not find or access repository at $REPO_PATH" >&2
        exit 1
      fi

      # 2. Add all changes, regardless of where the script is run from
      git add .

      # 3. Attempt commit, capturing the output (quietly by default)
      # Commit changes (if any)
      if git commit -m "$COMMIT_MESSAGE"; then
        echo "SUCCESS: Changes committed."
      else
        # Check if it's because there are no changes (exit code 1)
        # or a real error (other exit codes)
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
    (writeShellScriptBin "et" ''
      #!/usr/bin/env bash
      emacsclient -nw -s nekoserver
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

    # notes
    logseq
    obsidian
    joplin-desktop
    appflowy
    ticktick

    # nix
    nil
    nixd
    nixfmt-rfc-style
  ];
}
