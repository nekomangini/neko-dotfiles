{ pkgs, ... }:

{
  # Fuzzel configuration - Cyber-Emerald Neon
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "FiraCode Nerd Font:size=11";

        icon-theme = "Papirus-Dark";

        horizontal-pad = 10;
        vertical-pad = 10;
        inner-pad = 6;

        line-height = 20;
        lines = 10;

        use-bold = true;

        width = 40;

        terminal = "${pkgs.kitty}/bin/kitty";
      };

      border = {
        width = 2; # Slightly thicker for that glowing edge effect
        radius = 8;
      };

      # Colors sampled from the Cyan/Emerald wallpaper
      colors = {
        background = "0D1616EB"; # Deep dark teal-black (matches the shadows)
        text = "E0F7F2FF"; # Off-white with a hint of cyan
        match = "43F2D6FF"; # Bright Neon Cyan (the primary light source)
        selection = "1A3D37D9"; # Deep Emerald background for selection
        selection-text = "43F2D6FF"; # Cyan text for selected item
        selection-match = "5FC497FF"; # Emerald green for matches within selection
        border = "43F2D666"; # Semi-transparent Cyan border
        placeholder = "5FC49788"; # Dim Emerald for placeholders
      };

      dmenu = {
        mode = "text";
      };
    };
  };
}
