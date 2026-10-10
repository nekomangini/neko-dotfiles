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
    # "ctrl+t" = "launch --type=tab --tab-title \"Tmux Session\" tmux a";

    # Tab navigation
    "ctrl+shift+1" = "goto_tab 1";
    "ctrl+shift+2" = "goto_tab 2";
    "ctrl+shift+3" = "goto_tab 3";
    "ctrl+shift+4" = "goto_tab 4";
    "ctrl+shift+5" = "goto_tab 5";
    "ctrl+shift+6" = "goto_tab 6";
    "ctrl+shift+7" = "goto_tab 7";
    "ctrl+shift+8" = "goto_tab 8";
    "ctrl+shift+9" = "goto_tab 9";
  };
}
