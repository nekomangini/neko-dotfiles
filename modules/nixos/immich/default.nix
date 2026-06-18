{ ... }:

{
  services.immich = {
    enable = true;
    openFirewall = true;
    port = 2283;
    host = "0.0.0.0";
    mediaLocation = "/mnt/D/photos/immich";

    settings = null;
  };

  services.redis.servers.immich.logLevel = "warning";
}
