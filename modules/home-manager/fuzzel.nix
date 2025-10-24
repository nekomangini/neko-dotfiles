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

      # Renna/Ranni colors - exact match from waybar theme
      colors = {
        background = "0A0C1CEB";
        text = "E0EBFFFF";
        match = "7EB3FFFF";
        selection = "141932D9";
        selection-text = "7EB3FFFF";
        selection-match = "4A8FFFEE";
        border = "5B9FFF66";
        placeholder = "A8B8D8CC";
      };

      dmenu = {
        mode = "text";
      };
    };
  };
}
