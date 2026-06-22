{ ... }:

{
  services.postgresql = {
    enable = true;

    ensureDatabases = [
      "wiki-js"
    ];

    ensureUsers = [
      {
        name = "wiki-js";
        ensureDBOwnership = true;
      }
    ];
  };

  services.wiki-js = {
    enable = true;

    settings = {
      port = 3005;

      db = {
        type = "postgres";
        host = "/run/postgresql";
        db = "wiki-js";
        user = "wiki-js";
      };
    };
  };

  systemd.services.wiki-js = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };

  networking.firewall.allowedTCPPorts = [
    3005
  ];
}
