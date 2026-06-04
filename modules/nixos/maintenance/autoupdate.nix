{ ... }:

{
  # ===============================================
  # AUTOMATIC SYSTEM MAINTENANCE
  # ===============================================

  # 1. Auto System Update
  system.autoUpgrade = {
    # WARN: May cause sudden system reboots if allowReboot is set to true
    enable = true;
    dates = "weekly";
    allowReboot = false;
    operation = "switch";
  };

  # 2. Auto Cleanup (Garbage Collection)
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";

  # 3. Store Optimisation
  nix.settings.auto-optimise-store = true;
}
