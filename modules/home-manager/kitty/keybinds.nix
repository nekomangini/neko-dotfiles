{ ... }:
{

  # Keybindings
  programs.kitty.keybindings = {
    # Tab management
    "ctrl+shift+t" = "new_tab";
    "ctrl+shift+w" = "close_tab";
    "ctrl+shift+right" = "next_tab";
    "ctrl+shift+left" = "previous_tab";

    # Window management
    "ctrl+shift+enter" = "new_window";
    "ctrl+shift+n" = "new_os_window";

    # Font size
    "ctrl+shift+equal" = "increase_font_size";
    "ctrl+shift+minus" = "decrease_font_size";
    "ctrl+shift+backspace" = "restore_font_size";

    # Scrollback
    "ctrl+shift+k" = "scroll_line_up";
    "ctrl+shift+j" = "scroll_line_down";
    "ctrl+shift+page_up" = "scroll_page_up";
    "ctrl+shift+page_down" = "scroll_page_down";
    "ctrl+shift+home" = "scroll_home";
    "ctrl+shift+end" = "scroll_end";
  };
}
