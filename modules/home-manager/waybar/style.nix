{ ... }:

{
  programs.waybar.style = ''
    /* Twilight Frost - Redesigned Waybar */
    * {
      margin: 0;
      padding: 0;
      border: none;
      border-radius: 0;
      font-family: "FiraCode Nerd Font", "Cascadia Code", monospace;
      font-size: 12px;
      min-height: 0;
    }

    @define-color alice_blue #E7EFFE;
    @define-color vintage_grape #413F60;
    @define-color icy_blue #BFD8FC;
    @define-color dusk_blue #4D619E;
    @define-color baby_blue_ice #A5BAF0;
    @define-color alice_blue_2 #F6FCFE;
    @define-color prussian_blue #181E35;
    @define-color twilight_indigo #2E395B;

    /* Main Bar */
    #waybar {
      background: linear-gradient(135deg, rgba(24, 30, 53, 0.95) 0%, rgba(46, 57, 91, 0.9) 100%);
      border: 1px solid rgba(77, 97, 158, 0.4);
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
      color: @baby_blue_ice;
      font-size: 20px;
      padding: 5px 0 5px 7px;
    }

    /* Workspaces */
    #workspaces {
      border-radius: 10px;
      padding: 3px 0 3px 5px;
      margin-right: 10px;
    }

    #workspaces button {
      background: rgba(46, 57, 91, 0.6);
      color: @icy_blue;
      padding: 4px 11px;
      margin: 3px 3px;
      border-radius: 7px;
      border: 1px solid rgba(77, 97, 158, 0.3);
      font-weight: 500;
      min-width: 28px;
      transition: all 300ms ease;
      text-shadow: 0 0 6px rgba(165, 186, 240, 0.6);
      box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.4);
    }

    #workspaces button:hover {
      background: linear-gradient(135deg, rgba(77, 97, 158, 0.4), rgba(46, 57, 91, 0.35));
      color: @alice_blue;
      border-color: rgba(77, 97, 158, 0.6);
      box-shadow:
        0 0 8px rgba(77, 97, 158, 0.5),
        inset 0 1px 2px rgba(191, 216, 252, 0.15);
    }

    #workspaces button.active {
      background: linear-gradient(135deg, @dusk_blue 0%, @baby_blue_ice 100%);
      color: @prussian_blue;
      font-weight: 700;
      border: 1px solid @icy_blue;
      box-shadow: 0 0 12px rgba(165, 186, 240, 0.7);
    }

    #workspaces button.urgent {
      background: linear-gradient(135deg, rgba(255, 80, 80, 0.5), rgba(255, 60, 60, 0.4));
      color: #ffe0e0;
      border-color: rgba(255, 80, 80, 0.8);
      box-shadow: 0 0 12px rgba(255, 80, 80, 0.6);
    }

    /* Clock */
    #clock {
      background: linear-gradient(135deg, rgba(77, 97, 158, 0.75), rgba(46, 57, 91, 0.7));
      color: @alice_blue;
      padding: 4px 11px;
      margin: 5px 5px;
      border-radius: 7px;
      letter-spacing: 0.08em;
      border: 1px solid rgba(165, 186, 240, 0.4);
      text-shadow: 0 0 10px rgba(165, 186, 240, 0.8);
      font-weight: 600;
      box-shadow:
        0 3px 10px rgba(0, 0, 0, 0.4),
        inset 0 1px 2px rgba(231, 239, 254, 0.1);
    }

    /* Stat Modules */
    #temperature,
    #cpu,
    #memory,
    #network,
    #pulseaudio,
    #tray {
      background: linear-gradient(135deg, rgba(46, 57, 91, 0.65), rgba(24, 30, 53, 0.7));
      color: @alice_blue;
      padding: 4px 11px;
      margin: 5px 5px;
      border-radius: 7px;
      margin-left: 5px;
      border: 1px solid rgba(77, 97, 158, 0.3);
      transition: all 300ms ease;
      box-shadow: 
        0 2px 5px rgba(0, 0, 0, 0.4),
        inset 0 1px 1px rgba(165, 186, 240, 0.1);
    }

    #temperature:hover,
    #cpu:hover,
    #memory:hover,
    #network:hover,
    #pulseaudio:hover {
      background: linear-gradient(135deg, rgba(77, 97, 158, 0.5), rgba(165, 186, 240, 0.3));
      color: @alice_blue_2;
      border-color: @baby_blue_ice;
      box-shadow:
        0 4px 8px rgba(165, 186, 240, 0.6),
        inset 0 1px 2px rgba(191, 216, 252, 0.2);
    }

    /* Critical States */
    #temperature.critical,
    #cpu.critical,
    #memory.critical {
      background: linear-gradient(135deg, rgba(255, 70, 70, 0.5), rgba(200, 50, 50, 0.45));
      color: @alice_blue_2;
      border-color: rgba(255, 80, 80, 0.8);
      box-shadow:
        0 0 10px rgba(255, 70, 70, 0.6),
        inset 0 1px 2px rgba(255, 100, 100, 0.3);
    }

    /* Muted Audio State */
    #pulseaudio.muted {
      background: linear-gradient(135deg, rgba(65, 63, 96, 0.6), rgba(46, 57, 91, 0.55));
      color: @icy_blue;
      border-color: @vintage_grape;
      box-shadow:
        0 0 10px rgba(65, 63, 96, 0.5),
        inset 0 1px 2px rgba(65, 63, 96, 0.3);
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
      color: @alice_blue;
      font-size: 16px;
      padding: 4px 11px;
      margin: 5px 5px;
      background: linear-gradient(135deg, rgba(77, 97, 158, 0.6), rgba(46, 57, 91, 0.55));
      border-radius: 8px;
      border: 1px solid rgba(165, 186, 240, 0.4);
      transition: all 300ms ease;
      box-shadow: 0 2px 6px rgba(77, 97, 158, 0.4);
    }

    #custom-control:hover {
      background: linear-gradient(135deg, rgba(255, 80, 100, 0.6), rgba(255, 60, 80, 0.5));
      color: @alice_blue_2;
      border-color: rgba(255, 80, 100, 0.8);
      box-shadow: 
        0 4px 14px rgba(255, 80, 100, 0.6),
        inset 0 1px 2px rgba(255, 120, 120, 0.3);
    }
  '';
}
