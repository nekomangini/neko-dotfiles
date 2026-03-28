{ pkgs, ... }:

{
  xsession.windowManager.i3.config.startup = [
    # ===== SYSTEM SERVICES =====
    # TODO
    # {
    #   command = "dex-autostart --autostart --environment i3";
    #   notification = false;
    # }
    # {
    #   command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
    #   notification = false;
    # }
    # {
    #   command = "nm-applet";
    #   notification = false;
    # }

    # ===== COMPOSITOR & WALLPAPER =====
    # NOTE: I'll enable this when I just want to look at my wallpaper and not work :)
    # {
    #   command = "picom";
    #   notification = false;
    # }
    # {
    #   # FIX
    #   # command = "feh --bg-fill ~/neko-dotfiles/wallpaper/cars_036.jpg ~/neko-dotfiles/wallpaper/itachi_014.jpg";
    #   command = "feh --no-xinerama --bg-fill ~/neko-dotfiles/wallpaper/cars_036.jpg";
    #   notification = false;
    # }

    # ===== NOTIFICATION & STATUS BAR =====
    {
      command = "dunst";
      notification = false;
    }

    # ===== POLKIT AGENT =====
    {
      command = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      notification = false;
    }

    # ===== EMACS DAEMON =====
    # FIX
    # {
    #   command = "emacs --daemon=nekoserver";
    #   notification = false;
    # }

    # ===== MONITOR SETUP ====
    {
      command = "xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate right &";
    }

    # ===== STARTUP APPLICATIONS =====
    {
      command = "exec ${pkgs.kitty}/bin/kitty";
      notification = false;
    }
    {
      command = "sleep 3 && exec ${pkgs.vivaldi}/bin/vivaldi";
      notification = false;
    }
    {
      command = "sleep 3 && exec ${pkgs.kdePackages.dolphin}/bin/dolphin";
      notification = false;
    }
  ];
}
