{ ... }:

{
  programs.waybar.style = ''
    /* Rennala / Ranni the Witch - Redesigned Waybar (GTK3 Compatible) */
    * {
      margin: 0;
      padding: 0;
      border: none;
      border-radius: 0;
      font-family: "FiraCode Nerd Font", "Cascadia Code", monospace;
      font-size: 12px;
      min-height: 0;
    }

    @define-color bg_main rgba(10, 12, 28, 0.92);
    @define-color bg_modules rgba(20, 25, 50, 0.85);
    @define-color blue_primary #5b9fff;
    @define-color blue_bright #7eb3ff;
    @define-color blue_glow #4a8fff;
    @define-color violet_accent #7d6fd9;
    @define-color text_primary #e0ebff;
    @define-color text_dim #a8b8d8;

    /* Main Bar */
    #waybar {
      background: linear-gradient(135deg, @bg_main 0%, rgba(15, 18, 38, 0.7) 100%);
      border: 1px solid rgba(91, 159, 255, 0.25);
      border-radius: 8px;
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
      color: @blue_bright;
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
      background: rgba(30, 38, 70, 0.6);
      color: @text_dim;
      padding: 4px 11px;
      margin: 3px 3px;
      border-radius: 7px;
      border: 1px solid rgba(91, 159, 255, 0.12);
      font-weight: 500;
      min-width: 28px;
      transition: all 300ms ease;
      text-shadow: 0 0 8px rgba(126, 179, 255, 0.8);
      box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.3);
    }

    #workspaces button:hover {
      background: linear-gradient(135deg, rgba(91, 159, 255, 0.3), rgba(74, 143, 255, 0.25));
      color: @blue_bright;
      border-color: rgba(91, 159, 255, 0.6);
      box-shadow:
        0 0 7px rgba(91, 159, 255, 0.5),
        inset 0 1px 2px rgba(126, 179, 255, 0.3);
    }

    #workspaces button.active {
      background: linear-gradient(135deg, @blue_primary 0%, @blue_glow 100%);
      color: #0a0e1e;
      font-weight: 700;
      border: 1px solid rgba(126, 179, 255, 0.5);
    }

    #workspaces button.urgent {
      background: linear-gradient(135deg, rgba(255, 80, 80, 0.5), rgba(255, 60, 60, 0.4));
      color: #ffe0e0;
      border-color: rgba(255, 80, 80, 0.8);
      box-shadow: 0 0 12px rgba(255, 80, 80, 0.6);
    }

    /* Clock */
    #clock {
      background: linear-gradient(135deg, rgba(30, 35, 65, 0.7), rgba(25, 30, 58, 0.65));
      color: @blue_bright;
      padding: 4px 11px;
      margin: 5px 5px;
      border-radius: 7px;
      letter-spacing: 0.08em;
      border: 1px solid rgba(91, 159, 255, 0.25);
      text-shadow: 0 0 8px rgba(126, 179, 255, 0.8);
      font-weight: 500;
      box-shadow:
        0 3px 10px rgba(0, 0, 0, 0.3),
        inset 0 1px 2px rgba(126, 179, 255, 0.1);
    }

    /* Stat Modules */
    #temperature,
    #cpu,
    #memory,
    #network,
    #pulseaudio,
    #tray {
      background: linear-gradient(135deg, @bg_modules, rgba(25, 30, 55, 0.8));
      color: @text_primary;
      padding: 4px 11px;
      margin: 5px 5px;
      border-radius: 7px;
      margin-left: 5px;
      border: 1px solid rgba(91, 159, 255, 0.18);
      transition: all 300ms ease;
      box-shadow: 
        0 2px 5px rgba(0, 0, 0, 0.3),
        inset 0 1px 1px rgba(126, 179, 255, 0.1);
    }

    #temperature:hover,
    #cpu:hover,
    #memory:hover,
    #network:hover,
    #pulseaudio:hover {
      background: linear-gradient(135deg, rgba(91, 159, 255, 0.28), rgba(74, 143, 255, 0.22));
      color: @blue_bright;
      border-color: rgba(91, 159, 255, 0.5);
      box-shadow:
        0 4px 5px rgba(91, 159, 255, 0.4),
        inset 0 1px 2px rgba(126, 179, 255, 0.3);
    }

    /* Critical States */
    #temperature.critical,
    #cpu.critical,
    #memory.critical {
      background: linear-gradient(135deg, rgba(255, 70, 70, 0.4), rgba(255, 50, 50, 0.35));
      color: #ffe5e5;
      border-color: rgba(255, 80, 80, 0.8);
      box-shadow:
        0 0 7px rgba(255, 70, 70, 0.6),
        inset 0 1px 2px rgba(255, 100, 100, 0.3);
    }

    /* Muted Audio State */
    #pulseaudio.muted {
      background: linear-gradient(135deg, rgba(255, 70, 70, 0.4), rgba(255, 50, 50, 0.35));
      color: #ffe5e5;
      border-color: rgba(255, 80, 80, 0.8);
      box-shadow:
        0 0 7px rgba(255, 70, 70, 0.6),
        inset 0 1px 2px rgba(255, 100, 100, 0.3);
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
      color: @text_primary;
      font-size: 16px;
      padding: 4px 11px;
      margin: 5px 5px;
      background: linear-gradient(135deg, rgba(91, 159, 255, 0.15), rgba(125, 111, 217, 0.12));
      border-radius: 8px;
      border: 1px solid rgba(91, 159, 255, 0.25);
      transition: all 300ms ease;
      box-shadow: 0 2px 6px rgba(91, 159, 255, 0.2);
    }

    #custom-control:hover {
      background: linear-gradient(135deg, rgba(255, 80, 100, 0.35), rgba(255, 60, 80, 0.3));
      color: #ffe5e5;
      border-color: rgba(255, 80, 100, 0.6);
      box-shadow: 
        0 4px 14px rgba(255, 80, 100, 0.5),
        inset 0 1px 2px rgba(255, 120, 120, 0.3);
    }
  '';
}
