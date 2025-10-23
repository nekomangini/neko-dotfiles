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
        edit = "${pkgs.helix}/bin/hx {{filename}}";
        editAtLine = "${pkgs.helix}/bin/hx {{filename}}:{{line}}";
        editAtLineAndWait = "${pkgs.helix}/bin/hx {{filename}}:{{line}}";
        editInTerminal = true;
        openDirInEditor = "${pkgs.helix}/bin/hx {{dir}}";
      };

      gui = {
        showFileTree = true;
        showListFooter = true;
        showRandomTip = false;
        nerdFontsVersion = "3";
      };

      refresher = {
        refreshInterval = 10;
        fetchInterval = 60;
      };
    };
  };
}
