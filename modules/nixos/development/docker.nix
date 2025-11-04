{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  environment.systemPackages = with pkgs; [
    docker
  ];

  users.users.nekomangini.extraGroups = [ "docker" ];
}
