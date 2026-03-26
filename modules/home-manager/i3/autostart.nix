{ pkgs, ... }:

{
  xsession.windowManager.i3.config.startup = [
    # ===== SYSTEM SERVICES =====
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
    # {
    #   command = "picom";
    #   notification = false;
    # }
    # {
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
    {
      command = "emacs --daemon=nekoserver";
      notification = false;
    }

    # ===== MONITOR SETUP ====
    {
      command = "xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate right &";
    }

    # ===== STARTUP APPLICATIONS =====
    # {
    #   command = "i3-msg 'workspace 1; exec kitty -e tmux new-session -A -s main'";
    #   notification = false;
    # }
    # {
    #   command = "sleep 3 && i3-msg 'workspace 2; exec vivaldi-stable'";
    #   notification = false;
    # }
    # {
    #   command = "sleep 10 && i3-msg 'workspace 3; exec $HOME/Ticktick/ticktick.AppImage'";
    #   notification = false;
    # }
  ];
}
