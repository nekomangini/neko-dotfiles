{ config, ... }:

# TODO
# not imported to ../../../hosts/desktop/configuration.nix
{
  services.vaultwarden = {
    enable = true;
    backupDir = "/var/local/vaultwarden/backup";
    environmentFile = config.age.secrets."vaultwarden.env".path;
    config = {
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = 8222;
      SIGNUPS_ALLOWED = false;
      ROCKET_LOG = "critical";
    };
  };

  networking.firewall.allowedTCPPorts = [ 8222 ];
}
