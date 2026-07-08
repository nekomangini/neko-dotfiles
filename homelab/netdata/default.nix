{ pkgs, config, ... }:

{
  services.netdata = {
    enable = true;
    package = pkgs.netdata.override { withCloudUi = true; };
    config = {
      global = {
        "memory mode" = "ram";
        "debug log" = "none";
        "access log" = "none";
        "error log" = "syslog";
      };
    };
  };

  # Discord alert configuration
  environment.etc."netdata/health_alarm_notify.conf".source =
    config.age.secrets."netdata-discord".path;

  networking.firewall.allowedTCPPorts = [ 19999 ];
}
