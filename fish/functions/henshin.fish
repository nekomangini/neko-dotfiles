function henshin
    set -l THEME_NAME $argv[1]
    set -l AVAILABLE_THEMES \
        kanagawa \
        nord \
        catppuccin \
        neonpunk \
        gruvbox \
        aurora

    if test -z "$THEME_NAME"
        echo "Usage: switch_theme <theme-name>"
        echo "Available themes:"
        for theme in $AVAILABLE_THEMES
            echo "- $theme"
        end
        return 1
    end

    if contains $THEME_NAME $AVAILABLE_THEMES
        echo "{\"theme\": \"$THEME_NAME\"}" >"$HOME/.config/qtile/current_theme.json"
        qtile cmd-obj -o cmd -f restart
        echo "Theme switched to $THEME_NAME"
    else
        echo "Invalid theme name. Available themes:"
        for theme in $AVAILABLE_THEMES
            echo "- $theme"
        end
        return 1
    end
end
