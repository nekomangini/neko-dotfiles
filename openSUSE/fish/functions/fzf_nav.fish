function fzf_nav
    set -l DIRECTORIES \
        /home/nekomagini/neko-dotfiles/ \
        /home/nekomagini/scripts/ \
        /home/nekomangini/.config/nekovim/ \
        /home/nekomangini/.config/astronvim/

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
