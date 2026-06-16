{ ... }:

{
  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      MusicFolder = "/mnt/D/music";
      Address = "0.0.0.0";
    };
  };
}
