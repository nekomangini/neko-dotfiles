{ ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Unbind default prefix key (C-b) and change to (C-\)
      unbind C-b
      set -g prefix 'C-space'

      # Panes
      bind | split-window -h
      bind - split-window -v

      # Sessions
      bind N new-session -c "#{pane_current_path}";
      bind c new-window  -c "#{pane_current_path}";
    '';
  };
}
