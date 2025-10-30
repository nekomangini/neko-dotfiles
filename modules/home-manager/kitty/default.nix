{ ... }:
{
  imports = [
    ./theme.nix
    ./settings.nix
    ./keybinds.nix
  ];
  programs.kitty = {
    enable = true;
  };
}
