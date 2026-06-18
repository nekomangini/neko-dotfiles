{ ... }:

{
  services.kavita = {
    enable = true;
    tokenKeyFile = "/etc/kavita/token-key";
    settings = {
      Port = 3020;
    };
  };

  networking.firewall.allowedTCPPorts = [ 3020 ];
}
