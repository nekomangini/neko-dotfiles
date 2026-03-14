{
  # Hyprlock configuration - Cyber-Emerald
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
        no_fade_out = false;
      };

      # Background - Darkened Slate with Emerald Vibrancy
      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.5;
          vibrancy = 0.3;
          vibrancy_darkness = 0.1;
        }
      ];

      # Input field - Glassy Emerald
      input-field = [
        {
          monitor = "";
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          dots_rounding = -1;

          # Cyber-Emerald Palette
          outer_color = "rgb(0, 255, 159)";
          inner_color = "rgba(10, 20, 20, 0.8)";
          font_color = "rgb(200, 255, 230)";
          fade_on_empty = false;
          fade_timeout = 1000;

          placeholder_text = "<i>Enter password...</i>";

          check_color = "rgb(0, 255, 159)";
          fail_color = "rgb(255, 80, 80)";
          fail_text = "<i>Access Denied <b>($ATTEMPTS)</b></i>";

          position = "0, -120";
          halign = "center";
          valign = "center";
          rounding = 10;
        }
      ];

      # Time display
      label = [
        # Clock - Sharp Emerald Glow
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%I:%M $p")"'';
          color = "rgb(0, 255, 159)";
          font_size = 120;
          font_family = "FiraCode Nerd Font Bold";
          position = "0, 300";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 8;
          shadow_color = "rgba(0, 255, 159, 0.4)";
        }
        # Date - Cool Grey/Cyan
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgb(150, 200, 190)";
          font_size = 24;
          font_family = "FiraCode Nerd Font";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        # User greeting
        {
          monitor = "";
          text = "Welcome back: $USER";
          color = "rgb(200, 255, 230)";
          font_size = 18;
          font_family = "FiraCode Nerd Font";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
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
