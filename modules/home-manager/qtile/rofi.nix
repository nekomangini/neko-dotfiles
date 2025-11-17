{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";

    # Use custom Solarized theme
    theme = "solarized-squared";

    # Rofi behavior settings
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus-Dark";
    };
  };

  # Create the custom Solarized theme file
  home.file.".config/rofi/solarized-squared.rasi".text = ''
    /* ROFI SQUARED THEME USING SOLARIZED DARK PALETTE */
    /* Adapted to match Qtile Solarized theme */

    * {
        font:   "FiraCode Nerd Font Medium 12";
        
        /* Solarized Dark colors matching Qtile */
        bg0:     #002b36; /* base03 - main background */
        bg1:     #073642; /* base02 - secondary background/highlights */
        fg0:     #839496; /* base0 - body text/primary content */
        fg1:     #93a1a1; /* base1 - emphasized content */
        
        accent-color:     #268bd2; /* blue - active elements */
        urgent-color:     #dc322f; /* red - urgent elements */
        active-color:     #2aa198; /* cyan - active items */
        
        background-color:   transparent;
        text-color:         @fg0;
        
        margin:     0;
        padding:    0;
        spacing:    0;
    }

    window {
        location:   center;
        width:      480;
        background-color:   @bg0;
        border: 2px;
        border-color: @accent-color;
        border-radius: 8px;
    }

    inputbar {
        spacing:    8px;
        padding:    8px;
        background-color:   @bg1;
        border-radius: 4px;
    }

    prompt, entry, element-icon, element-text {
        vertical-align: 0.5;
    }

    prompt {
        text-color: @accent-color;
        font: "FiraCode Nerd Font Bold 12";
    }

    entry {
        text-color: @fg1;
    }

    textbox {
        padding:            8px;
        background-color:   @bg1;
    }

    listview {
        padding:    4px 0;
        lines:      8;
        columns:    1;
        fixed-height:   false;
        scrollbar: false;
    }

    element {
        padding:    8px;
        spacing:    8px;
        border-radius: 4px;
    }

    element normal normal {
        text-color: @fg0;
        background-color: transparent;
    }

    element normal urgent {
        text-color: @urgent-color;
        background-color: transparent;
    }

    element normal active {
        text-color: @active-color;
        background-color: transparent;
    }

    element alternate normal {
        text-color: @fg0;
        background-color: transparent;
    }

    element alternate active {
        text-color: @active-color;
        background-color: transparent;
    }

    element selected {
        text-color: @bg0;
        background-color: @accent-color;
    }

    element selected normal {
        background-color: @accent-color;
        text-color: @bg0;
    }

    element selected active {
        background-color: @active-color;
        text-color: @bg0;
    }

    element selected urgent {
        background-color: @urgent-color;
        text-color: @bg0;
    }

    element-icon {
        size:   0.8em;
        margin: 0 8px 0 0;
    }

    element-text {
        text-color: inherit;
    }
  '';
}
