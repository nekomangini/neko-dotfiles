{ ... }:

{
  services.forgejo = {
    enable = true;
    database.type = "sqlite3";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "192.168.1.72";
        HTTP_PORT = 3002;
        ROOT_URL = "http://192.168.1.72:3000/";
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
