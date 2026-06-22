{ ... }:

{
  virtualisation.oci-containers.containers.jotty = {
    image = "ghcr.io/fccview/jotty:latest";

    ports = [
      "3030:3000"
    ];

    volumes = [
      "/mnt/D/homelab/jotty/data:/app/data"
      "/mnt/D/homelab/jotty/config:/app/config"
      "/mnt/D/homelab/jotty/cache:/app/.next/cache"
    ];

    environment = {
      NODE_ENV = "production";
    };

    autoStart = true;
  };

  networking.firewall.allowedTCPPorts = [ 3030 ];
}
