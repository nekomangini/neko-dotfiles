{ pkgs, ... }:

let
  wallpaperPath = ../../wallpaper/evangelion_018.png;
  wallpaperv2Path = ../../wallpaper/wonyoung_002.jpeg;
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
        "HDMI-A-1,${wallpaperv2Path}"
      ];

      # Optional, but recommended for dynamic changes
      ipc = "on";
    };
  };
}
