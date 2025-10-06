function ndir
  set -l DIRECTORIES \
    /run/media/nekomangini/D/Programming/android-projects/flutter-projects/                     \
    /run/media/nekomangini/D/Programming/neko-gitjournal/                                       \
    /run/media/nekomangini/D/Programming/Projects/                                              \
    /run/media/nekomangini/D/Programming/dotfiles/                                              \
    /run/media/nekomangini/D/Programming/neko-dotfiles/                                         \
    /run/media/nekomangini/D/Programming/fedora-dotfiles/                                       \
    /run/media/nekomangini/D/Programming/helix_config/                                          \
    /run/media/nekomangini/D/Programming/kakoune_config/                                        \
    /run/media/nekomangini/D/Programming/blender-python/                                        \
    /run/media/nekomangini/D/Programming/scripts/                                               \
    /run/media/nekomangini/D/Programming/git-practice/                                          \
    /run/media/nekomangini/D/emacs-save-files/emacs-org-sync/                                   \
    /run/media/nekomangini/D/scratchpad-opensuse/                                               \
    /run/media/nekomangini/D/Programming/obsidian-notes                                         \
    /run/media/nekomangini/D/obsidian-files/nekomangini/                                        \
    /run/media/nekomangini/D/Programming/programming-exercises/                                 \
    /run/media/nekomangini/D/game-development/save-files/                                       \
    /home/nekomangini/.config/nekovim/                                                          \
    /home/nekomangini/.config/nvim/                                                             \
    /home/nekomangini/.config/astronvim_v5/                                                     \
    /home/nekomangini/.local/bin/bash-scripts/                                                  \
    /home/nekomangini/rose-pine-temp
  set -l SELECTED_DIR (printf "%s\n" $DIRECTORIES | fzf --height 40% --reverse --prompt="Select a directory: ")

  if test -n "$SELECTED_DIR"
    cd "$SELECTED_DIR" || begin
    echo "Failed to navigate to $SELECTED_DIR"
    return 1
  end
  # echo "Navigated to $SELECTED_DIR"
  else
    echo "No directory selected."
  end
end
