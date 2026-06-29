{ config, lib, ... }:

let
  cfg = config.myModules.ndir;
  pathsStr = lib.concatStringsSep "\n" cfg.directories;
in

{
  options.myModules.ndir = {
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "List of directories for ndir to jump to";
    };
  };

  config = {
    # generates ~/.config/ndir-paths via home-manager
    home.file.".config/ndir-paths".text = pathsStr;
  };
}
