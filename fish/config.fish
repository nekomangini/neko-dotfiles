# greeting
# function fish_greeting
#     random choice "Hello!" Hi uwu Nekomangini
# end

############################
####### alias ##############
############################
alias hx='helix'
alias ..='cd ..'
#### eza alias
alias ls='eza -l --header --icons'
# git
# alias ls='eza -l --git --git-repos --header --icons'
# tree view
# alias ls='eza --tree --level=2 --git --git-repos --header --icons'
alias lf='ranger'
# alias avim='NVIM_APPNAME="avim" nvim'
# nk is the alias and nekovim is the folder name
alias nk='NVIM_APPNAME="nekovim" nvim'

# alias for neovide
# alias nv='~/Downloads/neovide.AppImage'
function nvide
    nohup ~/Downloads/neovide.AppImage >/dev/null 2>&1 & disown
end

function lvide
    nohup ~/.config/lvim/lvim-nvide.sh >/dev/null 2>&1 & disown
end

# function nvim_custom
#     XDG_CONFIG_HOME="$HOME/.config/nekovim/" neovide
# end




############################
######### zoxide ###########
############################
# Initialize zoxide
zoxide init fish | source
# Change to the home directory on startup
# cd ~

############################
###### bash-scripts #######
############################
# set -x PATH $HOME/.local/bin/bash-scripts $PATH
set -U fish_user_paths $fish_user_paths ~/.local/bin/bash-scripts
alias tmux-ses='tmux-sessionizer.sh'

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
set -gx PATH $PATH $HOME/.gem/ruby/3.3.0/bin
alias rails='ruby -r rubygems -e "require \"rails/cli\"; Rails::CLI.start"'
# alias for jekyll
alias jekyll='jekyll.ruby3.3'
# alias for ruby on rails
alias rails='rails.ruby3.3'

# ghcup
set -x PATH $HOME/.cabal/bin $HOME/.ghcup/bin $PATH

# !! Contents within this block are managed by juliaup !!
switch (string match -r '.*:/home/nekomangini/.juliaup/bin:.*' $PATH)
    case "*"
        # Already in PATH, do nothing

    case "*"
        # Add to PATH
        set -gx PATH /home/nekomangini/.juliaup/bin $PATH

end

# nim
# export PATH=/home/nekomangini/.nimble/bin:$PATH
set -gx PATH /home/nekomangini/.nimble/bin $PATH

# Rust
# function source_bash_env
#     set -l env_file "$HOME/.cargo/env"
#     if test -f $env_file
#         # Source the env file in a bash sub-shell and export the variables to Fish
#         for line in (bash -c "source $env_file && env | grep -E 'CARGO|RUST'")
#             set -l key (echo $line | cut -d '=' -f 1)
#             set -l value (echo $line | cut -d '=' -f 2-)
#             set -gx $key $value
#         end
#     end
# end

# source_bash_env
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


# doom emacs
set -x PATH $HOME/.emacs.d/bin/ $PATH

# ada: alire(ada package manager)
# set -x PATH /home/nekomangini/ada_language_server/ $PATH
set -x PATH /home/nekomangini/alr-2.0.2-bin-x86_64-linux/bin $PATH
set -x PATH /home/nekomangini/.local/share/alire/toolchains/gprbuild_22.0.1_24dfc1b5/bin $PATH

# skia
# set -gx PATH (pwd)/depot_tools $PATH
# set -gx PATH /home/nekomangini/deps/skia/third_party/externals/emsdk $PATH
# set -gx PATH /home/nekomangini/deps/skia/third_party/externals/emsdk/node/14.18.2_64bit/bin $PATH
# set -gx PATH /home/nekomangini/deps/skia/third_party/externals/emsdk/upstream/emscripten $PATH
# set -x SKIA_DIR /run/media/nekomangini/D/skia/
# set -x SKIA_LIBRARY_DIR /run/media/nekomangini/D/skia/out/Release/
# set -x SKIA_LIBRARY skia
# set -x SKIA_DIR /run/media/nekomangini/D/skia/
# set -x SKIA_LIBRARY_DIR /run/media/nekomangini/D/skia/out/Release/
# set -x SKIA_LIBRARY /run/media/nekomangini/D/skia/out/Release/libskia.a
# set -x SKIA_LIBRARY /run/media/nekomangini/D/skia/out/Release/libskia.a
# set -Ux fish_user_paths /run/media/nekomangini/D/skia/third_party/externals/emsdk $fish_user_paths
# set -Ux fish_user_paths /run/media/nekomangini/D/skia/third_party/externals/emsdk/upstream/emscripten $fish_user_paths
# cmake -G Ninja \
#       -DLAF_BACKEND=skia \
#       -DSKIA_DIR=/run/media/nekomangini/D/skia \
#       -DSKIA_LIBRARY=/run/media/nekomangini/D/skia/out/Release/libskia.a \
#       -DSKIA_LIBRARY_DIR=/run/media/nekomangini/D/skia/out/Release \
#       ..
# cmake -G Ninja \
#       -DLAF_BACKEND=skia \
#       -DSKIA_DIR=/run/media/nekomangini/D/skia \
#       -DSKIA_LIBRARY=/run/media/nekomangini/D/skia/out/Release/libskia.a \
#       -DSKIA_LIBRARY_DIR=/run/media/nekomangini/D/skia/out/Release \
#       -DUSE_SHARED_FMT=OFF ..

# There is a compatibility issues with sdkman in fish shell
# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# set -x SDKMAN_DIR $HOME/.sdkman
# if test -s "$HOME/.sdkman/bin/sdkman-init.fish"
#     source $HOME/.sdkman/bin/sdkman-init.fish
# end

# using bass
# set -x SDKMAN_DIR "$HOME/.sdkman"
# test -s "$HOME/.sdkman/bin/sdkman-init.sh"; and bass source "$HOME/.sdkman/bin/sdkman-init.sh"
#
# set -x SDKMAN_DIR "$HOME/.sdkman"
# if test -s "$HOME/.sdkman/bin/sdkman-init.sh"
#     # Directly set PATH and other environment variables
#     set -x PATH $HOME/.sdkman/candidates/*/current/bin $PATH
#     
#     # Load SDKMAN functions
#     function sdk
#         bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk $argv"
#     end
# end

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


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/nekomangini/.opam/opam-init/init.fish' && source '/home/nekomangini/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration