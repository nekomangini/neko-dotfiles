{ ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Unbind default prefix key (C-b) and change to (C-\)
      unbind C-b
      set -g prefix 'C-\'

      # Panes
      bind | split-window -h
      bind - split-window -v

      # Sessions
      bind N new-session -c "#{pane_current_path}"
      bind c new-window  -c "#{pane_current_path}"

      # --- Color Fixes ---
      # Enable true color support
      set -g default-terminal "tmux-256color"

      # Enable true color (24-bit) support
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -ga terminal-overrides ",xterm-kitty:Tc"    '';
  };
}
