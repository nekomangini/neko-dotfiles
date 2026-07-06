{ ... }:

{
  services.adguardhome = {
    enable = true;
    mutableSettings = false;
    host = "0.0.0.0";
    port = 3004;
    settings = {
      dns = {
        bind_hosts = [ "0.0.0.0" ];
        upstream_dns = [
          "https://dns.cloudflare.com/dns-query"
          "tls://9.9.9.9"
          "tls://149.112.112.112"
        ];
        # Required when using DoH/DoT upstreams
        bootstrap_dns = [
          "1.1.1.1"
          "8.8.8.8"
          "9.9.9.9"
        ];
        upstream_mode = "parallel";
        cache_enabled = true;
        cache_size = 4194304;
        enable_dnssec = true;
        serve_plain_dns = true;
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;
        parental_enabled = false;
        safe_search.enabled = false;
        rewrites = [
          {
            domain = "*.home";
            answer = "192.168.1.200";
            enabled = true;
          }
        ];
      };
      filters =
        map
          (url: {
            enabled = true;
            inherit url;
          })
          [
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"
          ];
      querylog.enabled = true;
      statistics.enabled = true;
    };
  };

  networking.firewall.allowedTCPPorts = [
    53
    3004
  ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
