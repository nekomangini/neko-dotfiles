{ pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./keybinds.nix
    ./autostart.nix
    ./rules.nix
  ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      # Enable i3bar with i3status
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";

          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";

            focusedWorkspace = {
              border = "#4c7899";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }
      ];
    };
  };

  # i3status configuration
  programs.i3status = {
    enable = true;

    general = {
      colors = true;
      interval = 5;
    };

    modules = {
      # "wireless _first_" = {
      #   position = 1;
      #   settings = {
      #     format_up = "W: (%quality at %essid) %ip";
      #     format_down = "W: down";
      #   };
      # };

      "ethernet _first_" = {
        position = 2;
        settings = {
          format_up = "E: %ip (%speed)";
          format_down = "E: down";
        };
      };

      # "battery all" = {
      #   position = 3;
      #   settings = {
      #     format = "%status %percentage %remaining";
      #   };
      # };

      "disk /" = {
        position = 4;
        settings = {
          format = "/ %avail";
        };
      };

      # "load" = {
      #   position = 5;
      #   settings = {
      #     format = "%1min";
      #   };
      # };

      "memory" = {
        position = 6;
        settings = {
          format = "%used / %available";
          threshold_degraded = "1G";
          format_degraded = "MEMORY < %available";
        };
      };

      "tztime local" = {
        position = 7;
        settings = {
          format = "%Y-%m-%d %I:%M:%p";
        };
      };
    };
  };
}
