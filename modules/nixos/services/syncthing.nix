{ ... }:

{
  # syncthing
  services.syncthing = {
    enable = true;
    user = "nekomangini";
    dataDir = "/home/nekomangini/.config/syncthing";
    configDir = "/home/nekomangini/.config/syncthing";
    openDefaultPorts = true;
  };
}
