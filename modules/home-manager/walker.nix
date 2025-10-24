{ ... }:
{
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      # Set theme
      theme = "renna";

      # Basic search settings
      search.placeholder = "Search...";

      # List configuration
      list = {
        height = 500;
        always_show = true;
      };

      # Enable useful providers
      modules = [
        {
          name = "applications";
          prefix = "";
        }
        {
          name = "runner";
          prefix = ">";
        }
        {
          name = "websearch";
          prefix = "?";
        }
        {
          name = "ssh";
          prefix = "ssh";
        }
      ];

      # Keybindings
      keybinds = {
        down = "Down";
        up = "Up";
        quick_activate = [
          "F1"
          "F2"
          "F3"
        ];
      };
    };

    # Renna-inspired theme (moonlit blue with ethereal glow)
    themes = {
      "renna" = {
        style = ''
          * {
            font-family: "JetBrains Mono", monospace;
            font-size: 14px;
            color: #d4e6f1;
          }

          #window {
            background-color: rgba(20, 25, 45, 0.95);
            border: 2px solid rgba(100, 150, 200, 0.4);
            border-radius: 12px;
            box-shadow: 0 0 30px rgba(100, 150, 255, 0.3);
          }

          #input {
            background-color: rgba(30, 40, 70, 0.8);
            color: #c9dff5;
            padding: 12px;
            margin: 10px;
            border-radius: 8px;
            border: 1px solid rgba(120, 160, 220, 0.3);
            caret-color: #7fb3ff;
          }

          #input:focus {
            border-color: rgba(127, 179, 255, 0.6);
            box-shadow: 0 0 15px rgba(127, 179, 255, 0.2);
          }

          #list {
            background-color: transparent;
            padding: 5px;
          }

          #item {
            padding: 10px 15px;
            margin: 3px 10px;
            color: #b8d4f0;
            border-radius: 6px;
            background-color: rgba(30, 40, 70, 0.3);
            border: 1px solid transparent;
            transition: all 0.2s ease;
          }

          #item:hover {
            background-color: rgba(60, 80, 130, 0.4);
            border-color: rgba(100, 150, 200, 0.3);
          }

          #item:selected {
            background-color: rgba(80, 120, 180, 0.4);
            border-color: rgba(127, 179, 255, 0.5);
            color: #e8f4ff;
            box-shadow: 0 0 10px rgba(127, 179, 255, 0.2);
          }

          #item icon {
            margin-right: 10px;
            color: #7fb3ff;
          }

          #item text {
            color: inherit;
          }

          #item:selected icon {
            color: #a8d0ff;
          }

          scrollbar {
            background-color: transparent;
          }

          scrollbar slider {
            background-color: rgba(100, 150, 200, 0.3);
            border-radius: 10px;
          }

          scrollbar slider:hover {
            background-color: rgba(127, 179, 255, 0.5);
          }
        '';
      };
    };
  };
}
