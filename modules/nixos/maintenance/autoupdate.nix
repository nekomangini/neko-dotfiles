{ ... }:

{
  # ===============================================
  # AUTOMATIC SYSTEM MAINTENANCE
  # ===============================================

  # 1. Auto System Update
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # 2. Auto Cleanup (Garbage Collection)
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";

  # 3. Store Optimisation
  nix.settings.auto-optimise-store = true;
}
