# paths 
# bash-scripts path
# set -x PATH $HOME/.local/bin/bash-scripts $PATH
# set -U fish_user_paths $fish_user_paths ~/.local/bin/bash-scripts
fish_add_path ~/.local/bin/bash-scripts

# Rust path
# source_bash_env
# set -Ux fish_user_paths $HOME/.cargo/bin $fish_user_paths
fish_add_path $HOME/.cargo/bin

# FLUTTER PATH
set -x CHROME_EXECUTABLE /usr/bin/brave-browser
set -x PATH $PATH /opt/flutter/bin

# ruby path
set -gx GEM_HOME $HOME/.gem/ruby/3.3.0
fish_add_path $HOME/.gem/ruby/3.3.0/bin # set -gx PATH $PATH $HOME/.gem/ruby/3.3.0/bin
# gem path
set -gx PATH $PATH $HOME/.gem/ruby/3.4.0/bin $HOME/.gem/ruby/3.3.0/bin

# julia
# !! Contents within this block are managed by juliaup !!
switch ":$PATH:"
  case "*:/home/nekomangini/.juliaup/bin:*"
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

# zed text editor
set -x PATH $HOME/.local/bin $PATH

# scala
set -gx PATH $HOME/.local/share/coursier/bin $PATH

# clojure
set -x PATH $PATH /opt/infrastructure/clojure/bin/

# go 
# set -x PATH $PATH /usr/local/go/bin/
set -x PATH /usr/local/go/bin /home/nekomangini/go/bin $PATH

# haskell
# removed because of conflict in xmonad installation
# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /root/.ghcup/bin $PATH # ghcup-env 
# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
# haskell/ghcup
# set -x PATH $HOME/.cabal/bin $HOME/.ghcup/bin $PATH
# set -U fish_user_paths $HOME/.cabal/bin $fish_user_paths
# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/nekomangini/.ghcup/bin $PATH # ghcup-env

# doom emacs
set -x PATH $HOME/.emacs.d/bin/ $PATH

# ada: alire(ada package manager)
# set -x PATH /home/nekomangini/ada_language_server/ $PATH
set -x PATH /home/nekomangini/alr-2.0.2-bin-x86_64-linux/bin $PATH
set -x PATH /home/nekomangini/.local/share/alire/toolchains/gprbuild_22.0.1_24dfc1b5/bin $PATH

# fortls
set -x PATH /home/nekomangini/.local/bin/fortls $PATH

# skia

# blender
# set -x CYCLES_CUDA_EXTRA_FLAGS "-allow-unsupported-compiler"

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

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/nekomangini/.opam/opam-init/init.fish' && source '/home/nekomangini/.opam/opam-init/init.fish' >/dev/null 2>/dev/null; or true
# END opam configuration
