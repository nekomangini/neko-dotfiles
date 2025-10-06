function henshin
    set -l THEME_NAME $argv[1]
    set -l AVAILABLE_THEMES \
        aurora \
        bloodmoon \
        catppuccin \
        cheshirecat \
        evaasuka \
        gruvbox \
        itachi \
        kanagawa \
        matrix \
        neonpunk \
        nord \
        zerotwo \
        pywal

    # Use fzf to select a theme if no argument is provided
    if test -z "$THEME_NAME"
        set THEME_NAME (printf "%s\n" $AVAILABLE_THEMES | fzf --height 40% --reverse --prompt="Select a theme: ")
    end

    # Check if a theme was selected or provided
    if test -z "$THEME_NAME"
        echo "Usage: henshin <theme-name>"
        echo "Available themes:"
        for theme in $AVAILABLE_THEMES
            echo "- $theme"
        end
        return 1
    end

    # Check if the theme is valid and apply it
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
# function henshin
#     set -l THEME_NAME $argv[1]
#     set -l AVAILABLE_THEMES \
#         kanagawa \
#         nord \
#         catppuccin \
#         neonpunk \
#         gruvbox \
#         aurora \
#         bloodmoon \
#         cheshirecat \
#         evaasuka
#
#     if test -z "$THEME_NAME"
#         echo "Usage: switch_theme <theme-name>"
#         echo "Available themes:"
#         for theme in $AVAILABLE_THEMES
#             echo "- $theme"
#         end
#         return 1
#     end
#
#     if contains $THEME_NAME $AVAILABLE_THEMES
#         echo "{\"theme\": \"$THEME_NAME\"}" >"$HOME/.config/qtile/current_theme.json"
#         qtile cmd-obj -o cmd -f restart
#         echo "Theme switched to $THEME_NAME"
#     else
#         echo "Invalid theme name. Available themes:"
#         for theme in $AVAILABLE_THEMES
#             echo "- $theme"
#         end
#         return 1
#     end
# end
