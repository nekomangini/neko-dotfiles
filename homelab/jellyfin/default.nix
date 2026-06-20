{ pkgs, ... }:

{
  imports = [ ./storage.nix ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "nekomangini";
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  # prevent sleep
  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHibernation = "no";
  };
}
