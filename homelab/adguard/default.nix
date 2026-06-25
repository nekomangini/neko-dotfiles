{ ... }:

# FIX
{
  services.adguardhome = {
    enable = true;

    # Web UI
    host = "0.0.0.0";
    port = 3004;

    settings = {
      dns = {
        # Listen on all interfaces
        bind_hosts = [ "0.0.0.0" ];

        # Encrypted upstream DNS
        upstream_dns = [
          "https://dns.cloudflare.com/dns-query"
          "tls://9.9.9.9"
          "tls://149.112.112.112"
        ];

        # Query all upstreams simultaneously and use the fastest answer
        upstream_mode = "parallel";

        # Cache
        cache_enabled = true;
        cache_size = 4194304;

        # DNSSEC validation
        enable_dnssec = true;

        # Local network clients
        serve_plain_dns = true;
      };

      filtering = {
        protection_enabled = true;
        filtering_enabled = true;

        parental_enabled = false;

        safe_search = {
          enabled = false;
        };

        # Future homelab DNS entries
        rewrites = [
          {
            domain = "immich.home";
            answer = "192.168.1.6";
          }
          {
            domain = "jellyfin.home";
            answer = "192.168.1.6";
          }
          {
            domain = "navidrome.home";
            answer = "192.168.1.6";
          }
          {
            domain = "forgejo.home";
            answer = "192.168.1.6";
          }
          {
            domain = "homepage.home";
            answer = "192.168.1.6";
          }
          {
            domain = "adguard.home";
            answer = "192.168.1.6";
          }
        ];
      };

      # Blocklists
      filters =
        map
          (url: {
            enabled = true;
            inherit url;
          })
          [
            # AdGuard Base Filter
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"

            # Malware domains
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"

            # Malicious URLs
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"
          ];

      # Logging
      querylog = {
        enabled = true;
      };

      statistics = {
        enabled = true;
      };

    };
  };

  networking.firewall.allowedTCPPorts = [
    53
    3004
  ];

  networking.firewall.allowedUDPPorts = [
    53
  ];
}
