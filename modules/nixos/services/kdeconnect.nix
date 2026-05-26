# KDE Connect - System Firewall Configuration
# ============================================
# Managed by NixOS (system-level).
# Opens the required TCP/UDP ports for KDE Connect device discovery and communication.
# Port range 1714-1764 is the official KDE Connect port range.
#
# Note: networking options cannot be set in Home Manager, hence this separate file.
# Companion file: modules/home-manager/kdeconnect.nix
# That file handles the user-level KDE Connect daemon and indicator.
#
# Usage: Imported in hosts/desktop/configuration.nix
{ ... }:

{
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges; # Same range as TCP
  };
}
