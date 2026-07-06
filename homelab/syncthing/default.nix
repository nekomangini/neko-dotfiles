{ ... }:

{
  # syncthing
  services.syncthing = {
    enable = true;
    user = "nekomangini";
    dataDir = "/mnt/D/emacs-org-sync";
    configDir = "/home/nekomangini/.config/syncthing";
    openDefaultPorts = true;

    guiAddress = "0.0.0.0:8384";

    settings = {
      folders = {
        "notes" = {
          path = "/mnt/D/homelab/sync/notes";
          devices = [
            "SM-A057F"
            "vivo 1920"
          ];
        };
      };

      devices = {
        "SM-A057F" = {
          id = "GOXVTWV-7DMTWCL-ZIJUV4K-IOPPZFK-O42NWT6-HBYSGWW-LPQQZYC-ATJ2NQR";
        };
        "vivo 1920" = {
          id = "CJXMOOA-WM7TGLR-WAOJJP3-MRUU6UR-NHIAKIZ-NO2L4FE-K6G6IUJ-WDWRDQY";
        };
      };
    };

  };
}
