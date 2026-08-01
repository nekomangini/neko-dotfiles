{ ... }:

{
  imports = [
    ./settings.nix
    ./theme.nix
  ];

  programs.alacritty = {
    enable = true;
  };
}
