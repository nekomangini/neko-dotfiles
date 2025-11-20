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
  };
}
