{ ... }:

{

  programs.git = {
    enable = true;

    extraConfig = {
      core.editor = "hx";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      os = {
        edit = "hx";
      };
    };
  };

}
