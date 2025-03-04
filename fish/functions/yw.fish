function yw
    set BASE_DIR /home/nekomangini/Pictures/wallpaper

    set SELECTED_DIR (find "$BASE_DIR" -type d -not -path "$BASE_DIR" -printf '%P\n' | fzf --preview "ls -la '$BASE_DIR/{}'" --height 50% --reverse)

    if test -z "$SELECTED_DIR"
        echo "No directory selected."
        return 1
    end

    set FULL_DIR "$BASE_DIR/$SELECTED_DIR"

    set SELECTED_FILE (find "$FULL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) -printf '%f\n' | fzf --preview "chafa --size=70x30 '$FULL_DIR/{}'" --height 50% --reverse)

    if test -n "$SELECTED_FILE"
        feh --bg-fill "$FULL_DIR/$SELECTED_FILE"
    else
        echo "No file selected."
    end
end
