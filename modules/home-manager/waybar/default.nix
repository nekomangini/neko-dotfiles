{ ... }:
{
  imports = [
    ./modules.nix
    ./style.nix
  ];
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        spacing = 0;
        height = 0;
        margin-top = 10;
        margin-right = 10;
        margin-bottom = 0;
        margin-left = 10;

        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "tray"
          "network"
          "pulseaudio"
          "temperature"
          "custom/gpu-temp"
          "cpu"
          "memory"
          "custom/control"
        ];
      };
    };
  };
}
