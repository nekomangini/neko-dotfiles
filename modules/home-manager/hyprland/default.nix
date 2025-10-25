{ ... }:
{
  imports = [
    ./environment.nix
    ./settings.nix
    ./autostart.nix
    ./keybinds.nix
    ./rules.nix
    ../scripts.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
