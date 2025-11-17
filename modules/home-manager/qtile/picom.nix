{ ... }:
{
  services.picom = {
    enable = true;

    # Backend and VSync
    backend = "glx";
    vSync = true;

    # Shadows
    shadow = true;
    shadowOffsets = [
      (-7)
      (-7)
    ];
    shadowOpacity = 0.75; # Default from openSUSE config
    shadowExclude = [
      "name = 'Notification'"
      "_GTK_FRAME_EXTENTS@:c"
    ];

    # Fading
    fade = true;
    fadeSteps = [
      0.03
      0.03
    ];
    fadeDelta = 10;

    # Opacity
    inactiveOpacity = 0.8;
    activeOpacity = 1.0;

    # Additional picom settings
    settings = {
      # Shadows
      shadow-radius = 7;

      # Opacity and transparency
      frame-opacity = 0.7;
      inactive-opacity-override = true;

      # Focus exclusions - prevent these from becoming transparent when inactive
      focus-exclude = [
        "class_g = 'Vivaldi-stable'"
        "class_g = 'okular'"
      ];

      # Opacity rules for specific applications
      opacity-rule = [
        "90:class_g = 'Emacs'"
        "90:class_g = 'kitty'"
        "90:class_g = 'qutebrowser'"
        "100:class_g = 'Godot'"
        "100:class_g = 'jetbrains-studio'"
        "100:class_g = 'Brave-browser' && !focused"
        "100:class_g = 'dev.zed.Zed'"
      ];

      # Rounded corners (disabled in your openSUSE config)
      corner-radius = 0;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'Qtile'"
        "QTILE_INTERNAL = 1"
        # "class_g = 'awesome' && name = 'Awesome drawin'"
        "class_g = 'qutebrowser'"
      ];

      # Background blur
      blur = {
        method = "gaussian";
        size = 8;
        deviation = 12.0;
      };
      blur-kern = "3x3box";
      blur-background-exclude = [
        "_GTK_FRAME_EXTENTS@:c"
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'brave'"
        "class_g = 'librewolf-default'"
        "class_g = 'Vivaldi-stable'"
        "class_g = 'okular'"
      ];

      # Window detection
      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      use-damage = true;

      # Logging
      log-level = "warn";

      # Animations (appear on open/show)
      animations = [
        {
          triggers = [
            "open"
            "show"
          ];
          preset = "appear";
          direction = "up";
          scale = 0.9;
          duration = 0.2;
        }
      ];

      # Window type specific settings
      wintypes = {
        tooltip = {
          fade = true;
          shadow = true;
          opacity = 0.75;
          focus = true;
          full-shadow = false;
        };
        dock = {
          shadow = false;
          clip-shadow-above = true;
        };
        dnd = {
          shadow = false;
        };
        popup_menu = {
          opacity = 0.8;
        };
        dropdown_menu = {
          opacity = 0.8;
        };
      };
    };
  };
}
