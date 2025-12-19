{ ... }:
{

  # Keybindings
  programs.kitty.keybindings = {
    # Tab management
    "ctrl+shift+l" = "next_tab";
    "ctrl+shift+h" = "previous_tab";

    # Scrollback
    "ctrl+shift+u" = "scroll_page_up";
    "ctrl+shift+d" = "scroll_page_down";

    # Create a new tab and connect to a tmux session
    "ctrl+t" = "launch --type=tab --tab-title \"Tmux Session\" tmux a";
  };
}
