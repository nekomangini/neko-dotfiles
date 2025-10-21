{ ... }:

{

  programs.kitty = {
    enable = true;
    # Optional: Add any other settings (e.g., font, theme)
    # font.size = 12.0;
    settings = {
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 0;
      shell_integration = "no-cursor";
    };
  };

}
