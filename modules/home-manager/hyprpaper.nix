{ pkgs, ... }:

let
  wallpaperPath = ../../wallpaper/frieren-2.jpeg;
  wallpaperv2Path = ../../wallpaper/frieren-3.png;
in
{
  home.packages = with pkgs; [ hyprpaper ];

  # 🚀 Configure the hyprpaper service
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;

    settings = {
      # 1. Preload: Hyprpaper needs to load the image into memory first.
      preload = [
        "${wallpaperPath}"
        "${wallpaperv2Path}"
      ];

      # 2. Wallpaper: Apply the preloaded image.
      # The ',' means "all monitors".
      wallpaper = [
        "DVI-D-1,${wallpaperPath}"
        "DP-1,${wallpaperv2Path}"
      ];

      # Optional, but recommended for dynamic changes
      ipc = "on";
    };
  };
}
