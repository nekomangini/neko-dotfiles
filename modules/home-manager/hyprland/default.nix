{ ... }:
{
  imports = [
    ./environment.nix
    ./settings.nix
    ./autostart.nix
    ./keybinds.nix
    ./rules.nix
    ../shell/scripts.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
