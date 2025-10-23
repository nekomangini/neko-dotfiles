{ pkgs, ... }:

{

  programs.git = {
    enable = true;

    extraConfig = {
      core.editor = "${pkgs.helix}/bin/hx";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      os = {
        edit = "${pkgs.helix}/bin/hx";
      };
    };
  };

}
