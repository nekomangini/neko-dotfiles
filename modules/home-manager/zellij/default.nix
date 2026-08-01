{ ... }:

{
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/layouts/dev.kdl".source = ./dev.kdl;
}
