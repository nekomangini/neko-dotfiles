{ ... }:

{

  # Hyprlock configuration
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        # Disable loading the wallpaper
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
        no_fade_out = false;
      };

      # Background - Renna/Ranni deep blue
      background = [
        {
          monitor = "";
          path = "screenshot"; # Uses a screenshot with blur
          blur_passes = 3;
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.7;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      # Input field for password
      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          dots_rounding = -1;

          # Colors from Renna/Ranni theme
          outer_color = "rgb(91, 159, 255)";
          inner_color = "rgb(10, 12, 28)";
          font_color = "rgb(224, 235, 255)";
          fade_on_empty = false;
          fade_timeout = 1000;

          placeholder_text = "<i>Enter Password...</i>";

          check_color = "rgb(126, 179, 255)";
          fail_color = "rgb(255, 80, 80)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";

          position = "0, -120";
          halign = "center";
          valign = "center";
        }
      ];

      # Time display
      label = [
        # Clock
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
          color = "rgb(126, 179, 255)";
          font_size = 120;
          font_family = "FiraCode Nerd Font";
          position = "0, 300";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 5;
          shadow_color = "rgb(74, 143, 255)";
        }
        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgb(168, 184, 216)";
          font_size = 24;
          font_family = "FiraCode Nerd Font";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        # User greeting
        {
          monitor = "";
          text = "Welcome back, $USER";
          color = "rgb(224, 235, 255)";
          font_size = 20;
          font_family = "FiraCode Nerd Font";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  # Optional: Setup hypridle for auto-lock
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # Avoid starting multiple instances
        before_sleep_cmd = "loginctl lock-session"; # Lock before sleep
        after_sleep_cmd = "hyprctl dispatch dpms on"; # Turn on screen after sleep
      };

      listener = [
        # Dim screen after 5 minutes
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        # Lock after 10 minutes
        {
          timeout = 600;
          on-timeout = "loginctl lock-session";
        }
        # Turn off screen after 15 minutes
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
