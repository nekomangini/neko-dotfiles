{ ... }:

{
  # i3status configuration
  programs.i3status = {
    enable = true;
    enableDefault = false;

    general = {
      colors = true;
      interval = 5;
    };

    modules = {
      "ethernet _first_" = {
        position = 1;
        settings = {
          format_up = "E: %ip (%speed)";
          format_down = "E: down";
        };
      };

      "volume master" = {
        position = 2;
        settings = {
          format = "♪: %volume";
          format_muted = "♪: muted (%volume)";
          device = "default";
          mixer = "Master";
          mixer_idx = 0;
        };
      };

      "disk /" = {
        position = 3;
        settings = {
          format = "/ %avail";
        };
      };

      "memory" = {
        position = 4;
        settings = {
          format = "%used / %available";
          threshold_degraded = "1G";
          format_degraded = "MEMORY < %available";
        };
      };

      "tztime local" = {
        position = 5;
        settings = {
          format = "%Y-%m-%d %I:%M:%p";
        };
      };

      # "load" = {
      #   position = 5;
      #   settings = {
      #     format = "%1min";
      #   };
      # };

      # "battery all" = {
      #   position = 3;
      #   settings = {
      #     format = "%status %percentage %remaining";
      #   };
      # };

      # "wireless _first_" = {
      #   position = 1;
      #   settings = {
      #     format_up = "W: (%quality at %essid) %ip";
      #     format_down = "W: down";
      #   };
      # };
    };
  };
}
