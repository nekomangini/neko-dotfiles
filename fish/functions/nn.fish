function nn
    set -l DIRECTORIES \
        /run/media/nekomangini/D/Programming/neko-gitjournal/ \
        /run/media/nekomangini/D/Programming/Projects/front-end-projects/ \
        /run/media/nekomangini/D/Programming/android-projects/flutter-projects/flutter-foundations/ \
        /run/media/nekomangini/D/Programming/dotfiles/ \
        /run/media/nekomangini/D/Programming/neko-dotfiles/ \
        /run/media/nekomangini/D/game-development/save-files/Godot/godot_practice/ \
        /run/media/nekomangini/D/game-development/save-files/Godot/godot_yt_tutorials/ \
        /run/media/nekomangini/D/game-development/save-files/love2d/love2d-save-files/ \
        /run/media/nekomangini/D/game-development/save-files/defold/defold-practice-files/ \
        /run/media/nekomangini/D/Programming/scripts/ \
        /home/nekomangini/.local/bin/bash-scripts/ \
        /home/nekomangini/.config/nekovim/ \
        /home/nekomangini/.config/astronvim/ \
        /home/nekomangini/.config/lvim/ \
        /run/media/nekomangini/D/Programming/programming-exercises/basics/ \
        /run/media/nekomangini/D/Programming/programming-exercises/youtube-tutorials/ \
        /run/media/nekomangini/D/Programming/programming-exercises/frontend-development/ \
        /run/media/nekomangini/D/Programming/blender-python/ \
        /run/media/nekomangini/D/Programming/programming-exercises/book/ \
        /run/media/nekomangini/D/obsidian-files/nekomangini/

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
