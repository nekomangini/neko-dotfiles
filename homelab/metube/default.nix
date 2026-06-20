{ ... }:

{
  virtualisation.oci-containers.containers.metube = {
    image = "ghcr.io/alexta69/metube:latest";

    ports = [
      "8081:8081"
    ];

    volumes = [
      "/mnt/D/homelab/downloads/metube:/downloads"
    ];

    environment = {
      DOWNLOAD_DIR = "/downloads";
    };

    autoStart = true;
  };
}
