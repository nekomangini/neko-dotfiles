{ pkgs, ... }:

let
  # Git utility functions
  gitFunctions = ''
    # --- Return the current Git branch name ---
    function _git_branch_name
        if not ${pkgs.git}/bin/git rev-parse --is-inside-work-tree >/dev/null 2>&1
            return
        end
        set branch (${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD 2>/dev/null)
        echo $branch
    end

    # --- Return if Git repo is dirty (has uncommitted changes) ---
    function _is_git_dirty
        if not ${pkgs.git}/bin/git rev-parse --is-inside-work-tree >/dev/null 2>&1
            return
        end
        set dirty (${pkgs.git}/bin/git status -s --ignore-submodules=dirty 2>/dev/null)
        echo $dirty
    end

    # --- Return number of commits ahead of remote ---
    function _git_ahead_count
        if not ${pkgs.git}/bin/git rev-parse --is-inside-work-tree >/dev/null 2>&1
            return
        end
        set remote $argv[1]
        set branch_name $argv[2]
        set count (${pkgs.git}/bin/git log $remote/$branch_name..HEAD 2>/dev/null | grep '^commit' | wc -l | tr -d ' ')
        echo $count
    end

    # --- Check remote differences and display colored symbols ---
    function _git_dirty_remotes
        if not ${pkgs.git}/bin/git rev-parse --is-inside-work-tree >/dev/null 2>&1
            return
        end

        set remote_color $argv[1]
        set ahead_color $argv[2]
        set current_branch (${pkgs.git}/bin/git rev-parse --abbrev-ref HEAD 2>/dev/null)
        set current_ref (${pkgs.git}/bin/git rev-parse HEAD 2>/dev/null)

        # Skip if detached HEAD
        if test "$current_branch" = "HEAD"
            return
        end

        for remote in (${pkgs.git}/bin/git remote | grep -E 'origin|upstream')
            set git_ahead_count (_git_ahead_count $remote $current_branch)
            set remote_branch "refs/remotes/$remote/$current_branch"
            set remote_ref (${pkgs.git}/bin/git for-each-ref --format='%(objectname)' $remote_branch)

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
  '';

  # Prompt functions
  promptFunctions = ''
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
  '';

  # Custom utility functions
  utilityFunctions = ''
    # yazi - file manager with directory changing
    function y
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      ${pkgs.yazi}/bin/yazi $argv --cwd-file="$tmp"
      if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          builtin cd -- "$cwd"
      end
      rm -f -- "$tmp"
    end

    # ndir - directory jumper with fzf
    function ndir
      set -l DIRECTORIES \
                    ~/neko-dotfiles \
                    /run/media/nekomangini/D/Programming/{android-projects,neko-gitjournal,Projects,dotfiles,blender-python,scripts,programming-exercises} \
                    /run/media/nekomangini/D/emacs-org-sync \
                    /run/media/nekomangini/D/game-development/save-files \
                    ~/.config/{nekovim,nvim,astronvim_v5} \

        # Filter to only existing directories
        set -l EXISTING_DIRS
        for dir in $DIRECTORIES
            test -d "$dir" && set -a EXISTING_DIRS "$dir"
        end
        
        if test (count $EXISTING_DIRS) -eq 0
            echo "No directories available. Check if paths exist." >&2
            return 1
        end

        set -l SELECTED_DIR (printf "%s\n" $EXISTING_DIRS | ${pkgs.fzf}/bin/fzf --height 40% --reverse --prompt="Select a directory: ")

        if test -n "$SELECTED_DIR"
            cd "$SELECTED_DIR" && echo "Changed to: $SELECTED_DIR" || echo "Failed to navigate to $SELECTED_DIR"
        else
            echo "No directory selected."
        end
    end
  '';

in

{
  programs.fish.interactiveShellInit = ''
    ${gitFunctions}
    ${promptFunctions}
    ${utilityFunctions}
  '';
}
