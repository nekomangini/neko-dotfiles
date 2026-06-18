{ ... }:

{
  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "3001";
      HOST = "0.0.0.0";
    };
  };

  networking.firewall.allowedTCPPorts = [ 3001 ];
}
