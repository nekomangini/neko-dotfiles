{ ... }:

{
  programs.alacritty.settings = {
    colors = {
      primary = {
        background = "#080c0c";
        foreground = "#a3b8b5";
      };

      cursor = {
        text = "#080c0c";
        cursor = "#43f2d6";
      };

      selection = {
        text = "#43f2d6";
        background = "#1a2b28";
      };

      normal = {
        black = "#0a1211";
        red = "#ff4d4d";
        green = "#5fc497";
        yellow = "#d4b55e";
        blue = "#36a3d9";
        magenta = "#9b6bdf";
        cyan = "#43f2d6";
        white = "#cbd9d7";
      };

      bright = {
        black = "#2a3b38";
        red = "#ff6e6e";
        green = "#7ef2be";
        yellow = "#f0d082";
        blue = "#71beeb";
        magenta = "#c29ef3";
        cyan = "#a2f9ec";
        white = "#e6efee";
      };
    };
  };
}
