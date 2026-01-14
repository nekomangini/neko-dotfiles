{
  programs.waybar.style = ''
    /* Everforest - Waybar Theme */
    * {
      margin: 0;
      padding: 0;
      border: none;
      border-radius: 0;
      font-family: "FiraCode Nerd Font", "Cascadia Code", monospace;
      font-size: 12px;
      min-height: 0;
    }

    @define-color fg #D3C6AA;
    @define-color red #E67E80;
    @define-color yellow #DBBC7F;
    @define-color green #A7C080;
    @define-color blue #7FBBB3;
    @define-color purple #D699B6;
    @define-color aqua #83C092;
    @define-color orange #E69875;
    @define-color grey0 #7A8478;
    @define-color grey1 #859289;
    @define-color grey2 #9DA9A0;
    @define-color bg_dim #1E2326;
    @define-color bg0 #272E33;
    @define-color bg1 #2E383C;
    @define-color bg2 #374145;
    @define-color bg3 #414B50;
    @define-color bg4 #495156;
    @define-color bg5 #4F5B58;

    /* Main Bar */
    #waybar {
      background: linear-gradient(135deg, rgba(30, 35, 38, 0.95) 0%, rgba(46, 56, 60, 0.9) 100%);
      border: 1px solid rgba(131, 192, 146, 0.3);
      border-radius: 0px;
    }

    /* Container Spacing */
    #modules-left,
    #modules-center,
    #modules-right {
      background: transparent;
      padding: 4px 6px;
    }

    /* Custom Launcher */
    #custom-launcher {
      color: @green;
      font-size: 20px;
      padding: 5px 0 5px 0;
    }

    /* Workspaces */
    #workspaces {
      border-radius: 10px;
      padding: 3px 0 3px 0;
      margin-right: 10px;
    }

    #workspaces button {
      background: rgba(46, 56, 60, 0.6);
      color: @grey2;
      padding: 4px 11px;
      margin: 3px 3px;
      border-radius: 7px;
      border: 1px solid rgba(131, 192, 146, 0.2);
      font-weight: 500;
      min-width: 28px;
      transition: all 300ms ease;
      text-shadow: 0 0 6px rgba(167, 192, 128, 0.4);
      box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.4);
    }

    #workspaces button:hover {
      background: linear-gradient(135deg, rgba(65, 75, 80, 0.5), rgba(55, 65, 69, 0.4));
      color: @fg;
      border-color: rgba(131, 192, 146, 0.5);
      box-shadow:
        0 0 8px rgba(131, 192, 146, 0.4),
        inset 0 1px 2px rgba(167, 192, 128, 0.15);
    }

    #workspaces button.active {
      background: linear-gradient(135deg, @green 0%, @aqua 100%);
      color: @bg0;
      font-weight: 700;
      border: 1px solid @aqua;
      box-shadow: 0 0 12px rgba(167, 192, 128, 0.6);
    }

    #workspaces button.urgent {
      background: linear-gradient(135deg, rgba(230, 126, 128, 0.5), rgba(230, 126, 128, 0.4));
      color: @fg;
      border-color: rgba(230, 126, 128, 0.8);
      box-shadow: 0 0 12px rgba(230, 126, 128, 0.6);
    }

    /* Clock */
    #clock {
      background: linear-gradient(135deg, rgba(65, 75, 80, 0.75), rgba(55, 65, 69, 0.7));
      color: @fg;
      padding: 4px 11px;
      margin: 5px 5px;
      border-radius: 7px;
      letter-spacing: 0.08em;
      border: 1px solid rgba(167, 192, 128, 0.3);
      text-shadow: 0 0 10px rgba(131, 192, 146, 0.6);
      font-weight: 600;
      box-shadow:
        0 3px 10px rgba(0, 0, 0, 0.4),
        inset 0 1px 2px rgba(211, 198, 170, 0.1);
    }

    /* Stat Modules */
    #temperature,
    #custom-gpu-temp,
    #cpu,
    #memory,
    #network,
    #pulseaudio,
    #tray {
      background: linear-gradient(135deg, rgba(46, 56, 60, 0.65), rgba(39, 46, 51, 0.7));
      color: @fg;
      padding: 4px 11px;
      margin: 5px 5px;
      border-radius: 7px;
      margin-left: 5px;
      border: 1px solid rgba(131, 192, 146, 0.25);
      transition: all 300ms ease;
      box-shadow: 
        0 2px 5px rgba(0, 0, 0, 0.4),
        inset 0 1px 1px rgba(167, 192, 128, 0.1);
    }

    #temperature:hover,
    #custom-gpu-temp:hover,
    #cpu:hover,
    #memory:hover,
    #network:hover,
    #pulseaudio:hover {
      background: linear-gradient(135deg, rgba(65, 75, 80, 0.6), rgba(131, 192, 146, 0.3));
      color: @fg;
      border-color: @aqua;
      box-shadow:
        0 4px 8px rgba(131, 192, 146, 0.5),
        inset 0 1px 2px rgba(167, 192, 128, 0.2);
    }

    /* Critical States */
    #temperature.critical,
    #custom-gpu-temp.critical,
    #cpu.critical,
    #memory.critical {
      background: linear-gradient(135deg, rgba(230, 126, 128, 0.5), rgba(230, 126, 128, 0.45));
      color: @fg;
      border-color: rgba(230, 126, 128, 0.8);
      box-shadow:
        0 0 10px rgba(230, 126, 128, 0.6),
        inset 0 1px 2px rgba(230, 126, 128, 0.3);
    }

    /* Muted Audio State */
    #pulseaudio.muted {
      background: linear-gradient(135deg, rgba(55, 65, 69, 0.6), rgba(46, 56, 60, 0.55));
      color: @grey1;
      border-color: @grey0;
      box-shadow:
        0 0 10px rgba(122, 132, 120, 0.4),
        inset 0 1px 2px rgba(122, 132, 120, 0.3);
    }

    /* System Tray */
    #tray {
      padding: 4px 11px;
      margin: 5px 5px;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .active {
      -gtk-icon-effect: highlight;
    }

    /* Custom Control (Power) */
    #custom-control {
      color: @fg;
      font-size: 16px;
      padding: 4px 11px;
      margin: 5px 5px;
      background: linear-gradient(135deg, rgba(65, 75, 80, 0.6), rgba(55, 65, 69, 0.55));
      border-radius: 8px;
      border: 1px solid rgba(167, 192, 128, 0.3);
      transition: all 300ms ease;
      box-shadow: 0 2px 6px rgba(131, 192, 146, 0.3);
    }

    #custom-control:hover {
      background: linear-gradient(135deg, rgba(230, 126, 128, 0.6), rgba(230, 126, 128, 0.5));
      color: @fg;
      border-color: rgba(230, 126, 128, 0.8);
      box-shadow: 
        0 4px 14px rgba(230, 126, 128, 0.6),
        inset 0 1px 2px rgba(230, 126, 128, 0.3);
    }
  '';
}
