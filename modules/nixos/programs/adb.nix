{ ... }:

# NOTE
# no longer needed in 26.05, use pkgs.android-tools
{
  # Android ADB udev rules
  programs.adb.enable = true;
}
