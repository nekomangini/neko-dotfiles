{ ... }:

{
  # Enable qtile
  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages =
      python3Packages: with python3Packages; [
        qtile-extras
      ];
  };

  # NOTE:
  # https://discourse.nixos.org/t/breaking-changes-announcement-for-unstable/17574/78
  # Enable this to prevent authentication failure
  programs.i3lock.enable = true;
}
