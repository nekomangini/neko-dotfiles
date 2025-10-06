# set -Ux EDITOR nvim

############################
# bash-scripts
function tmux-ses
  # alias tmux-ses='tmux-sessionizer.sh'
  tmux-sessionizer.sh $argv
end

############################
# zoxide
zoxide init fish | source

############################
# theme
# Source the fish_greeting.fish script
source ~/.config/fish/fish_greeting.fish
source ~/.config/fish/fish_prompt.fish
source ~/.config/fish/fish_right_prompt.fish

if status is-interactive
  # Commands to run in interactive sessions can go here
end

