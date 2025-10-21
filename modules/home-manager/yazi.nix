{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "e" ];
          run = ''shell "hx $@" --block --confirm'';
          desc = "Edit with Helix";
        }
      ];
    };
  };

}
