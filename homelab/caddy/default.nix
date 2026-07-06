{ ... }:

# FIX: Not working properly
{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "jellyfin.home" = {
        extraConfig = "reverse_proxy localhost:8096";
      };
      "navidrome.home" = {
        extraConfig = "reverse_proxy localhost:4533";
      };
      "kavita.home" = {
        extraConfig = "reverse_proxy localhost:3020";
      };
      "immich.home" = {
        extraConfig = "reverse_proxy localhost:2283";
      };
      "linkding.home" = {
        extraConfig = "reverse_proxy localhost:9090";
      };
      "radicale.home" = {
        extraConfig = "reverse_proxy localhost:5232";
      };
      "wikijs.home" = {
        extraConfig = "reverse_proxy localhost:3005";
      };
      "jotty.home" = {
        extraConfig = "reverse_proxy localhost:3030";
      };
      "uptime.home" = {
        extraConfig = "reverse_proxy localhost:3001";
      };
      "forgejo.home" = {
        extraConfig = "reverse_proxy localhost:3000";
      };
      "syncthing.home" = {
        extraConfig = "reverse_proxy localhost:8384";
      };
      "metube.home" = {
        extraConfig = "reverse_proxy localhost:8081";
      };
      "adguard.home" = {
        extraConfig = "reverse_proxy localhost:3004";
      };
      "dashboard.home" = {
        extraConfig = "reverse_proxy localhost:3333";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
