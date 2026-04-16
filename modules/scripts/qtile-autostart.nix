{ pkgs, ... }:

let
  qtileAutostart = pkgs.writeScriptBin "qtile-autostart" ''
    #!/usr/bin/env raku
    use v6.d;

    sub MAIN() {
        shell "picom &";

        # Monitor Setup (DVI Horizontal, HDMI Vertical)
        shell "xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate right &";

        # Wallpaper 
        shell "feh --bg-fill ${../../wallpaper/cars_034.png} ${../../wallpaper/space_009.jpg} &";

        # Polkit Agent 
        shell "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &";

        # Startup Apps
        shell "dunst &";
        shell "${pkgs.kitty}/bin/kitty &";
        
        # Delayed starts for heavier apps
        sleep 2;
        shell "${pkgs.ticktick}/bin/ticktick &";
        
        sleep 3;
        shell "${pkgs.kdePackages.dolphin}/bin/dolphin &";
        
        sleep 5;
        shell "${pkgs.vivaldi}/bin/vivaldi &";
    }
  '';
in
{
  home.packages = [ qtileAutostart ];
}
