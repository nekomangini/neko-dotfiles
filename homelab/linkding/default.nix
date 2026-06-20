{ ... }:

{
  virtualisation.podman.enable = true;

  virtualisation.oci-containers.containers.linkding = {
    autoStart = true;
    image = "sissbruecker/linkding:latest";
    volumes = [ "/var/lib/linkding/data:/etc/linkding/data" ];
    ports = [ "9090:9090" ];
  };

  systemd.tmpfiles.settings."10-linkding" = {
    "/var/lib/linkding/data" = {
      d = {
        mode = "0755";
        user = "root";
        group = "root";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 9090 ];
}
