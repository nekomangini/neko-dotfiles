{ pkgs, ... }:

{
  services.netdata = {
    enable = true;
    config = {
      global = {
        "memory mode" = "dbengine";
        "update every" = "1";
        "debug log" = "none";
        "access log" = "none";
        "error log" = "syslog";
      };
      web = {
        "bind to" = "0.0.0.0:19999";
        "allow connections from" = "localhost 192.168.1.*";
      };
    };
  };

  systemd.services.netdata.path = [ pkgs.linuxPackages.nvidia_x11 ];
  services.netdata.configDir."python.d.conf" = pkgs.writeText "python.d.conf" ''
    nvidia_smi: yes
  '';

  networking.firewall.allowedTCPPorts = [ 19999 ];
}
