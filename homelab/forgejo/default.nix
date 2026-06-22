{ ... }:

let
  pc-server = "192.168.1.6";
in

{
  services.forgejo = {
    enable = true;
    database.type = "sqlite3";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "${pc-server}";
        HTTP_PORT = 3002;
        ROOT_URL = "http://${pc-server}:3000/";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 3002 ];
}
