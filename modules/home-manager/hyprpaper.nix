{ pkgs, ... }:

let
  wallpaperPath = ../../wallpaper/wallhaven-3z895y.jpg;
in
{
  home.packages = with pkgs; [ hyprpaper ];

  # 🚀 Configure the hyprpaper service
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;

    settings = {
      # 1. Preload: Hyprpaper needs to load the image into memory first.
      preload = [ "${wallpaperPath}" ];

      # 2. Wallpaper: Apply the preloaded image.
      # The ',' means "all monitors".
      wallpaper = [ ",${wallpaperPath}" ];

      # Optional, but recommended for dynamic changes
      ipc = "on";
    };
  };
}
