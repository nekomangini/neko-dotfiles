{ ... }:

{
  # Import niri configuration from KDL file
  xdg.configFile."niri/config.kdl" = {
    source = ./config.kdl;
  };

  # Only add niri-specific packages that aren't already configured elsewhere
  # home.packages = with pkgs; [
  #   brightnessctl
  # ];
}
