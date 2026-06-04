# KDE Connect - User Service Configuration
# =========================================
# Managed by Home Manager (user-level).
# Enables the KDE Connect daemon and system tray indicator for the current user.
#
# Companion file: modules/nixos/services/kdeconnect.nix
# That file handles the system-level firewall rules required for device discovery.
#
# Usage: Import this in modules/home-manager/profiles/desktop.nix
{ pkgs, ... }:

{
  services.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde; # Qt6-based version
    indicator = true; # Show KDE Connect in the system tray
  };
}
