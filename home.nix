{ config, pkgs, ... }:

{
  home.username = "nekomangini";
  home.homeDirectory = "/home/nekomangini";
  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Example configurations
  programs.git = {
    enable = true;

    extraConfig = {
      core.editor = "hx";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      os = {
        editCommand = "hx";
      };
    };
  };

  programs.yazi = {
    package = pkgs.yazi.override { _7zz = _7zz-rar; }; 

    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "e" ];
          run = "shell 'hx \"$@"' --block --confirm";
          desc = "Edit with Helix";
        }
      ];
    };
  };

  programs.helix = {
    enable = true;
    package = pkgs.helix;

    settings = {
      theme = "everforest_dark";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        end-of-line-diagnostics = "hint";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        lsp.display-inlay-hints = true;
      };

      keys = {
        insert.j.k = "normal_mode";

        normal = {
          "C-g" = [
            ":new"
            ":insert-output lazygit"
            ":buffer-close!"
            ":redraw"
          ];

          "C-y" = [
            ":sh rm -f /tmp/unique-file"
            ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
            ''
            :insert-output echo "\x1b[?1049h\x1b[?2004h" > /dev/tty
            ''
            ":open %sh{cat /tmp/unique-file}"
            ":redraw"
          ];

          "space" = {
            F = "no_op";
            q = ":quit";
          };

          space.f = {
            F = "file_picker_in_current_directory";
            b = "file_picker_in_current_buffer_directory";
            f = "file_picker";
            o = ":open ~/.config/helix/config.toml";
            s = ":write";
          };
        };
      };
    };

    languages = {
      language = [
        {
          name = "html";
          language-servers = [ "vscode-html-language-server" "emmet-ls" ];
          auto-format = true;
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "css";
          language-servers = [ "vscode-css-language-server" "emmet-ls" ];
          auto-format = true;
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "javascript";
          language-servers = [ "typescript-language-server" "emmet-ls" ];
          auto-format = true;
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "typescript";
          language-servers = [ "typescript-language-server" "emmet-ls" ];
          auto-format = true;
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "jsx";
          language-servers = [ "typescript-language-server" "emmet-ls" ];
          auto-format = true;
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "tsx";
          language-servers = [ "typescript-language-server" "emmet-ls" ];
          auto-format = true;
          indent = { tab-width = 2; unit = "  "; };
        }
      ];

      language-server = {
        vscode-html-language-server = {
          command = "vscode-html-language-server";
          args = [ "--stdio" ];
        };
        vscode-css-language-server = {
          command = "vscode-css-language-server";
          args = [ "--stdio" ];
        };
        "typescript-language-server" = {
          command = "typescript-language-server";
          args = [ "--stdio" ];
        };
        "emmet-ls" = {
          command = "emmet-ls";
          args = [ "--stdio" ];
        };
      };
    };
  };

  programs.kitty = {
    enable = true;
    # Optional: Add any other settings (e.g., font, theme)
    # font.size = 12.0;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza -l --header --icons";
      lg = "lazygit";
    };
    shellInit = ''
      # paths
      set -gx EMACS_BIN_PATH $HOME/.config/emacs/bin
      fish_add_path $HOME/.config/emacs/bin
    '';
    interactiveShellInit = ''
      # --- Return the current Git branch name ---
      function _git_branch_name
          if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
              return
          end
          set branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
          echo $branch
      end

      # --- Return if Git repo is dirty (has uncommitted changes) ---
      function _is_git_dirty
          if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
              return
          end
          set dirty (command git status -s --ignore-submodules=dirty 2>/dev/null)
          echo $dirty
      end

      # --- Return number of commits ahead of remote ---
      function _git_ahead_count
          if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
              return
          end
          set remote $argv[1]
          set branch_name $argv[2]
          set count (command git log $remote/$branch_name..HEAD 2>/dev/null | grep '^commit' | wc -l | tr -d ' ')
          echo $count
      end

      # --- Check remote differences and display colored symbols ---
      function _git_dirty_remotes
          if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
              return
          end

          set remote_color $argv[1]
          set ahead_color $argv[2]
          set current_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
          set current_ref (command git rev-parse HEAD 2>/dev/null)

          # Skip if detached HEAD
          if test "$current_branch" = "HEAD"
              return
          end

          for remote in (git remote | grep -E 'origin|upstream')
              set git_ahead_count (_git_ahead_count $remote $current_branch)
              set remote_branch "refs/remotes/$remote/$current_branch"
              set remote_ref (git for-each-ref --format='%(objectname)' $remote_branch)

              if test -n "$remote_ref"
                  if test "$remote_ref" != "$current_ref"
                      if test "$git_ahead_count" -ne 0
                          echo -n "$remote_color!"
                          echo -n "$ahead_color+$git_ahead_count$normal"
                      end
                  end
              end
          end
      end

      # --- Display Git branch info with colors ---
      function _prompt_git -a gray normal orange red yellow
          test "$theme_display_git" = no; and return
          set -l git_branch (_git_branch_name)
          test -z $git_branch; and return

          if test "$theme_display_git_dirty" = no
              echo -n -s $gray '‹' $yellow $git_branch $gray '› '
              return
          end

          set dirty_remotes (_git_dirty_remotes $red $orange)

          if [ (_is_git_dirty) ]
              echo -n -s $gray '‹' $yellow $git_branch $red '*' $dirty_remotes $gray '› '
          else
              echo -n -s $gray '‹' $yellow $git_branch $red $dirty_remotes $gray '› '
          end
      end

      # --- Display current directory name ---
      function _prompt_pwd
          set -l cwd (basename (prompt_pwd))
          set -l blue (set_color blue)
          set -l gray (set_color 640)
          echo -n -s $gray $blue $cwd $gray
      end

      # --- Draw colored arrows depending on last command status ---
      function _prompt_status_arrows -a exit_code
          if test $exit_code -ne 0
              set arrow_colors red red red red  # Red = error
          else
              set arrow_colors green green green green  # Green = success
          end
          for arrow_color in $arrow_colors
              set_color $arrow_color
              printf '»'
          end
      end

      # --- The main Fish prompt ---
      function fish_prompt
          set -l exit_code $status
          set -l gray (set_color 640)
          set -l red (set_color red)
          set -l orange (set_color FF9500)
          set -l yellow (set_color yellow)
          set -l blue (set_color blue)
          set -l normal (set_color normal)

          # # Newline before prompt
          # printf '\n'

          # Show user@host and directory
          set_color green
          echo -n (whoami)
          set_color yellow
          echo -n '@'
          _prompt_pwd
          set_color normal
          printf '\n'

          # Show Git info if applicable
          _prompt_git $gray $normal $orange $red $yellow

          # Draw arrow indicators
          _prompt_status_arrows $exit_code

          printf ' '
          set_color normal
      end

      # --- Right prompt: exit code + time ---
      function fish_right_prompt
          set -l exit_code $status
          if test $exit_code -ne 0
              set_color red
          else
              set_color green
          end
          printf '%d' $exit_code
          set_color 640
          echo '|'
          set_color 777
          printf '%s' (date +%I:%M:%S)
          set_color normal
      end

      # zoxide
      zoxide init fish | source

      # yazi
      function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      end

      # TODO:
      function ndir
          set -l DIRECTORIES \
              "/home/nekomangini/neko-dotfiles" \
              "/run/media/nekomangini/D/Programming/android-projects/" \
              "/run/media/nekomangini/D/Programming/neko-gitjournal" \
              "/run/media/nekomangini/D/Programming/Projects" \
              "/run/media/nekomangini/D/Programming/fedora-dotfiles" \
              "/run/media/nekomangini/D/Programming/blender-python" \
              "/run/media/nekomangini/D/Programming/scripts" \
              "/run/media/nekomangini/D/Programming/git-practice" \
              "/run/media/nekomangini/D/emacs-save-files/emacs-org-sync" \
              "/run/media/nekomangini/D/Programming/programming-exercises" \
              "/run/media/nekomangini/D/game-development/save-files" \
              "/home/nekomangini/.config/nekovim" \
              "/home/nekomangini/.config/nvim" \
              "/home/nekomangini/.config/astronvim_v5" \
              "/home/nekomangini/.local/bin/bash-scripts"

          set -l SELECTED_DIR (printf "%s\n" $DIRECTORIES | fzf --height 40% --reverse --prompt="Select a directory: ")
          if test -n "$SELECTED_DIR"
              cd "$SELECTED_DIR" || begin
                  echo "Failed to navigate to $SELECTED_DIR"
                  return 1
              end
          else
              echo "No directory selected."
          end
      end
    '';
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
      set -e
      cd /run/media/nekomangini/D/emacs-save-files/emacs-org-sync || exit 1
      git add .
      git commit -m "update notes $(date +%m-%d-%Y)" || echo "Nothing to commit"
      git push origin main
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
  ];
}
