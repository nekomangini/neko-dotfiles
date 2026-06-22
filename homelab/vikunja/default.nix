{ ... }:

{
  services.vikunja = {
    enable = true;
    frontendScheme = "http";
    frontendHostname = "localhost";
  };

  networking.firewall.allowedTCPPorts = [ 3456 ];
}
