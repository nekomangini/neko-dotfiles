{ ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        # Geometry and positioning
        width = 320;
        height = 280;
        offset = "10x10";
        origin = "top-right";
        notification_limit = 5;

        # Progress bar styling
        progress_bar = true;
        progress_bar_height = 12;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 280;
        progress_bar_max_width = 300;

        # Appearance
        transparency = 8;
        separator_height = 2;
        padding = 12;
        horizontal_padding = 14;
        text_icon_padding = 8;
        frame_width = 1;
        gap_size = 6;
        separator_color = "frame";
        sort = true;

        # Font and text
        font = "FiraCode Nerd Font 11";
        line_height = 2;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;

        # Icons
        icon_position = "left";
        min_icon_size = 24;
        max_icon_size = 48;

        # Interaction
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        sticky_history = true;
        history_length = 20;

        # Animations and timing
        idle_threshold = 120;
        corner_radius = 8;
      };

      # Low priority notifications
      urgency_low = {
        background = "#0a0c1c"; 
        foreground = "#e0ebff"; 
        frame_color = "#5b9fff4d"; 
        timeout = 5;
      };

      # Normal priority notifications
      urgency_normal = {
        background = "#141932"; 
        foreground = "#e0ebff"; 
        frame_color = "#5b9fff"; 
        timeout = 8;
      };

      # Critical notifications
      urgency_critical = {
        background = "#1a1020"; 
        foreground = "#ffe5e5"; 
        frame_color = "#ff5050cc"; 
        timeout = 0; # Don't auto-dismiss critical
      };
    };
  };
}
