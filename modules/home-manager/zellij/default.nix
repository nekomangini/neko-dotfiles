{ ... }:

{
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/layouts/dev.kdl".source = ./dev.kdl;
  xdg.configFile."zellij/layouts/dots.kdl".source = ./dots.kdl;
}
