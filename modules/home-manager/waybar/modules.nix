{ ... }:
{
  programs.waybar.settings.mainBar = {
    "custom/launcher" = {
      format = " ";
      tooltip = false;
    };

    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      tooltip = false;
    };

    tray = {
      spacing = 10;
      tooltip = false;
    };

    clock = {
      format = "{:%I:%M - %a, %b %d %Y}";
      tooltip = false;
    };

    temperature = {
      thermal-zone = 2;
      hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
      critical-threshold = 80;
      format = "temp {temperatureC}°C";
      format-critical = "temp {temperatureC}°C";
      interval = 2;
      states = {
        critical = 80;
      };
    };

    "custom/gpu-temp" = {
      exec = "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits";
      format = "gpu {}°C";
      interval = 2;
      tooltip = false;
    };

    cpu = {
      format = "cpu {usage}%";
      interval = 2;
      states = {
        critical = 90;
      };
    };

    memory = {
      format = "mem {percentage}%";
      interval = 2;
      states = {
        critical = 80;
      };
    };

    network = {
      format-wifi = "wifi {bandwidthDownBits}";
      format-ethernet = "enth {bandwidthDownBits}";
      format-disconnected = "no network";
      interval = 5;
      tooltip = false;
    };

    pulseaudio = {
      scroll-step = 5;
      max-volume = 150;
      format = "vol {volume}%";
      format-bluetooth = "vol {volume}%";
      format-muted = "muted";
      nospacing = 1;
      on-click = "pwvucontrol";
      tooltip = false;
    };

    "custom/control" = {
      format = "⏻";
      on-click = "hyprctl dispatch exit";
      tooltip = false;
    };
  };
}
