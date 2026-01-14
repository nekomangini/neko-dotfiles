{ pkgs, ... }:

{
  # Fuzzel configuration - Renna/Ranni inspired
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
        width = 1;
        radius = 8;
      };

      # Everforest colors
      colors = {
        background = "272E33EB"; # Background 0 with transparency
        text = "D3C6AAFF"; # Foreground
        match = "A7C080FF"; # Green (highlighted matches)
        selection = "3C4841D9"; # Background Green with transparency
        selection-text = "D3C6AAFF"; # Foreground
        selection-match = "83C092EE"; # Aqua (matched text in selection)
        border = "A7C08066"; # Green with transparency
        placeholder = "859289CC"; # Grey 1 with transparency
      };

      dmenu = {
        mode = "text";
      };
    };
  };
}
