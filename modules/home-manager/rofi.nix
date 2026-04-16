{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";

    theme = "dark-minimal";

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      display-drun = " ";
      display-run = " ";
      display-window = " ";
      drun-display-format = "{name}";
    };
  };

  # Minimal theme
  home.file.".config/rofi/dark-minimal.rasi".text = ''
    * {
    font: "FiraCode Nerd Font Medium 11";

        /* Deep Dark Palette */
        bg0:    #0a0a0a; /* Almost black */
        bg1:    #1a1a1a; /* Dark gray for highlights */
        bg2:    #262626; /* Selection background */
        fg0:    #e6e6e6; /* Bright text */
        fg1:    #999999; /* Muted text */
        
        accent: #5e81ac; /* Muted blue (Frost) or swap for #ffffff for monochrome */
        urgent: #bf616a; /* Muted red */

        background-color:   transparent;
        text-color:         @fg0;
        
        margin:     0;
        padding:    0;
        spacing:    0;
    }

    window {
        location:           center;
        width:              400; /* Slimmer for minimalism */
        background-color:   @bg0;
        border:             1px;
        border-color:       @bg2;
        border-radius:      0px; /* Sharp corners for i3 look */
    }

    inputbar {
        spacing:            12px;
        padding:            12px;
        background-color:   @bg1;
        children:           [ prompt, entry ];
    }

    prompt {
        text-color:         @accent;
    }

    entry {
        placeholder:        "Search...";
        placeholder-color:  @fg1;
        text-color:         @fg0;
    }

    listview {
        lines:              8;
        columns:            1;
        fixed-height:       false;
        border:             0px;
        padding:            5px 0px;
    }

    element {
        padding:            8px 12px;
        spacing:            8px;
    }

    element normal.normal {
        background-color:   transparent;
        text-color:         @fg0;
    }

    element selected.normal {
        background-color:   @bg2;
        text-color:         @accent;
    }

    element alternate.normal {
        background-color:   transparent;
        text-color:         @fg0;
    }

    element-icon {
        size:               1.2em;
        cursor:             inherit;
    }

    element-text {
        text-color:         inherit;
        cursor:             inherit;
        vertical-align:     0.5;
    }


  '';
}
