{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nix-server";
  symlink = config.lib.file.mkOutOfStoreSymlink;
in

{
  xdg.configFile."doom" = {
    source = symlink "${dotfiles}/modules/home-manager/emacs/doom";
  };
}
