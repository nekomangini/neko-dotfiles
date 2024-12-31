# Harleen Theme. Made with <3.
# code from https://github.com/aneveux/theme-harleen/blob/master/fish_prompt.fish

function _git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
    # Retrieving status of last command
    # Directly using it to set colors for displaying prompt symbols
    test $status -ne 0
    and set -l last_status_colors 666 aaa f02093
    or set -l last_status_colors 666 aaa 03adf1

    # Defining some helper functions for playing with colors.
    # Thanks to http://www.colourlovers.com/palette/4537580/lisa_frank_rainbow~ for the colors inspiration :)
    set -l color_pink (set_color -o f02093)
    set -l color_yellow (set_color -o fdf215)
    set -l color_green (set_color -o abd543)
    set -l color_blue (set_color -o 03adf1)
    set -l color_purple (set_color -o a23095)
    set -l color_dim (set_color -o c0c0c0)
    set -l color_off (set_color -o normal)

    # Defining symbols to use for information in Git repositories
    set -l stashed "^"
    set -l ahead "↑"
    set -l behind "↓"
    set -l diverged "⥄ "
    set -l dirty "*"
    set -l none ""

    # output the prompt, left to right

    # Add a newline before prompts
    echo -e ""

    # Display [venvname] if in a virtualenv
    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b cyan black) '['(basename "$VIRTUAL_ENV") ']' $normal ' '
    end

    # Display the current directory name
    set -l cwd (basename (prompt_pwd))
    echo -n -s $color_blue "("$color_dim $cwd $color_blue")" $color_off " "

    # Show git branch and dirty state
    if [ (_git_branch_name) ]
        set -l git_branch '('(_git_branch_name) ')'

        if [ (_is_git_dirty) ]
            set git_info $red $git_branch " ★ "
        else
            set git_info $green $git_branch
        end
        echo -n -s '· ' $git_info $normal
    end

    # Finally display the prompt symbols
    for color in $last_status_colors
        echo -n (set_color $color)">"
    end

    # Terminate with a nice prompt char
    echo -n -s ' ⟩ ' $color_off

end
