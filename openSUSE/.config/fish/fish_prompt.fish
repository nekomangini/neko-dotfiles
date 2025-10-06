# inspired from scorphish theme(https://github.com/oh-my-fish/theme-scorphish)
function _git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function _git_ahead_count -a remote -a branch_name
    echo (command git log $remote/$branch_name..HEAD 2> /dev/null | \
    grep '^commit' | wc -l | tr -d ' ')
end

function _git_dirty_remotes -a remote_color -a ahead_color
    set current_branch (command git rev-parse --abbrev-ref HEAD 2> /dev/null)
    set current_ref (command git rev-parse HEAD 2> /dev/null)
    for remote in (git remote | grep 'origin\|upstream')
        set -l git_ahead_count (_git_ahead_count $remote $current_branch)
        set remote_branch "refs/remotes/$remote/$current_branch"
        set remote_ref (git for-each-ref --format='%(objectname)' $remote_branch)
        if test "$remote_ref" != ''
            if test "$remote_ref" != $current_ref
                if [ $git_ahead_count != 0 ]
                    echo -n "$remote_color!"
                    echo -n "$ahead_color+$git_ahead_count$normal"
                end
            end
        end
    end
end

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

function _prompt_pwd
    set -l cwd (basename (prompt_pwd))
    echo -n -s $gray $blue $cwd $gray
end

function _prompt_status_arrows -a exit_code
    if test $exit_code -ne 0
        set arrow_colors red red red red # Red for errors
    else
        set arrow_colors green green green green # Green for success
    end
    for arrow_color in $arrow_colors
        set_color $arrow_color
        printf '»'
    end
end

function fish_prompt
    set -l exit_code $status
    # Original colors (grayish for loading time)
    set -l gray (set_color 640)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l yellow (set_color yellow)
    set -l blue (set_color blue)
    set -l normal (set_color normal)
    set -l user_color (set_color green)
    set -l sep_color (set_color yellow)

    echo -n -s $user_color (whoami) $sep_color "@"

    if test "$theme_display_pwd_on_second_line" != yes
        _prompt_pwd
    end

    printf '%s ⚡️ %0.3fs' $blue (math $CMD_DURATION / 1000)

    if set -q NEKOMANGINI_GIT_INFO_ON_FIRST_LINE
        set theme_display_git_on_first_line
    end

    if set -q theme_display_git_on_first_line
        _prompt_git $gray $normal $yellow $red $yellow
    end

    if test "$theme_display_pwd_on_second_line" = yes
        printf $gray'\n‹'
        _prompt_pwd
        printf $gray'›'
    end

    printf '\n'

    if not set -q theme_display_git_on_first_line
        _prompt_git $gray $normal $yellow $red $yellow
    end

    _prompt_status_arrows $exit_code
    printf ' '
    set_color normal
end
