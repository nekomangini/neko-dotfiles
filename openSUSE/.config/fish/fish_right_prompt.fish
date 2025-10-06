# Harleen theme only displays a clock on the right prompt...
# code from https://github.com/aneveux/theme-harleen/blob/master/fish_prompt.fish
# refactor by chatgpt

# function fish_right_prompt
#     set -l color_green (set_color -o abd543)
#     set -l color_dim (set_color -o c0c0c0)
#     set -l color_off (set_color -o normal)
#
#     echo -n -s $color_dim (date +%I$color_green:$color_dim%M$color_green:$color_dim%S)$color_off
#
# end

function fish_right_prompt
    set -l exit_code $status
    if test $exit_code -ne 0
        set_color red
    else
        set_color green
    end
    printf '%d' $exit_code
    set_color -o 640
    echo '|'
    set_color -o 777
    printf '%s' (date +%I:%M:%S)
    set_color normal
end
