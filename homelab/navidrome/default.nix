{ ... }:

{
  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      MusicFolder = "/mnt/D/homelab/media/music";
      Address = "0.0.0.0";
    };
  };
}
