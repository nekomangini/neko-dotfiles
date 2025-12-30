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
      # vim keybind
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R


      # Sessions
      bind N new-session -c "#{pane_current_path}";
      bind c new-window  -c "#{pane_current_path}";
      bind i switch-client -n
      bind o switch-client -p
    '';
  };
}
