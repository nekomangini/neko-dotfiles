############################
####### alias ##############
############################
alias hx='helix'
alias ..='cd ..'
#### eza alias
# alias ls='eza -l --header --icons'
# git
# alias ls='eza -l --git --git-repos --header --icons'
# tree view
alias ls='eza --tree --level=2 --git --git-repos --header --icons'
alias lf='ranger'
alias nk='NVIM_APPNAME="nekovim" nvim'
alias av='NVIM_APPNAME="astronvim" nvim'
# alias for neovide
alias nekovide='NVIM_APPNAME="nekovim" neovide'
function lvide
    nohup ~/.config/lvim/lvim-nvide.sh >/dev/null 2>&1 & disown
end


############################
######### zoxide ###########
############################
# Initialize zoxide
zoxide init fish | source


############################
###### bash-scripts #######
############################
set -U fish_user_paths $fish_user_paths ~/.local/bin/bash-scripts
alias nmix='nekomux.sh'


############################
########### fzf ############
############################
alias nf='nk (fzf --preview "cat {}" --height 70%)'


############################
######### theme ############
############################
# Source the fish_greeting.fish script
source ~/.config/fish/fish_greeting.fish
# Source the fish_prompt.fish script
source ~/.config/fish/fish_prompt.fish
source ~/.config/fish/fish_right_prompt.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

############################
########## paths ###########
############################
# FLUTTER PATH
set -x CHROME_EXECUTABLE /usr/bin/brave-browser
set -x PATH $PATH /opt/flutter/bin

# ruby path
set -gx GEM_HOME $HOME/.gem/ruby/3.3.0
fish_add_path $HOME/.gem/ruby/3.3.0/bin
alias jekyll='jekyll.ruby3.3'
alias rails='bundle exec rails' # alias rails='rails.ruby3.3'

# julia
# !! Contents within this block are managed by juliaup !!
switch (string match -r '.*:/home/nekomangini/.juliaup/bin:.*' $PATH)
    case "*"
        # Already in PATH, do nothing

    case "*"
        # Add to PATH
        set -gx PATH /home/nekomangini/.juliaup/bin $PATH

end

# nim
set -gx PATH /home/nekomangini/.nimble/bin $PATH

# source_bash_env
# TODO:
set -Ux fish_user_paths $HOME/.cargo/bin $fish_user_paths

# zed text editor
set -x PATH $HOME/.local/bin $PATH

# scala
set -gx PATH $HOME/.local/share/coursier/bin $PATH

# clojure
set -x PATH $PATH /opt/infrastructure/clojure/bin/

# go 
set -x PATH $PATH /usr/local/go/bin/

# haskell
# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /root/.ghcup/bin $PATH # ghcup-env 
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin /home/nekomangini/.ghcup/bin $PATH # ghcup-env
# haskell/ghcup
set -x PATH $HOME/.cabal/bin $HOME/.ghcup/bin $PATH


# doom emacs
set -x PATH $HOME/.emacs.d/bin/ $PATH

# TODO:
# ada: alire(ada package manager)
set -x PATH /home/nekomangini/alr-2.0.2-bin-x86_64-linux/bin $PATH
set -x PATH /home/nekomangini/.local/share/alire/toolchains/gprbuild_22.0.1_24dfc1b5/bin $PATH

# fortls
set -x PATH /home/nekomangini/.local/bin/fortls $PATH

# android sdk
set -x ANDROID_HOME /home/nekomangini/Android/Sdk
set -x ANDROID_SDK_ROOT /home/nekomangini/Android/Sdk
set -x PATH $PATH $ANDROID_HOME/tools $ANDROID_HOME/platform-tools

set -x SDKMAN_DIR "$HOME/.sdkman"
if test -s "$HOME/.sdkman/bin/sdkman-init.sh"
    # Parse and set environment variables from sdkman-init.sh
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && env | grep -E 'SDKMAN_|JAVA_HOME'" | while read -l line
        set parts (string split -m1 = $line)
        set -gx $parts[1] $parts[2]
    end

    # Update PATH
    set -gx PATH $SDKMAN_DIR/candidates/*/current/bin $PATH

    # Function to run sdk commands
    function sdk
        bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk $argv"
    end

    # Set JAVA_HOME if not already set
    if not set -q JAVA_HOME
        set -gx JAVA_HOME (dirname (dirname (which java)))
    end
end
