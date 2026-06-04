{ pkgs, ... }:

let
  wallpaperPath = ../../wallpaper/cats_008.jpg;
  wallpaperv2Path = ../../wallpaper/cats_007.jpg;
  wallpaperv3Path = ../../wallpaper/evangelion_017.jpg;
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
        "${wallpaperv3Path}"
      ];

      # 2. Wallpaper: Apply the preloaded image.
      # The ',' means "all monitors".
      wallpaper = [
        "DP-1,${wallpaperv3Path}"
        "DVI-D-1,${wallpaperPath}"
        "HDMI-A-1,${wallpaperv2Path}"
      ];

      # Optional, but recommended for dynamic changes
      ipc = "on";
    };
  };
}
