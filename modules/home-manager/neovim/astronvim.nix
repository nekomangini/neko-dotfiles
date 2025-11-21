{ pkgs, ... }:

{
  home.packages = [

    (pkgs.writeShellApplication {
      name = "av";
      runtimeInputs = [ pkgs.neovim ];
      text = ''
        export NVIM_APPNAME="astronvim-v5"
        exec ${pkgs.neovim}/bin/nvim "$@"
      '';
    })

    (pkgs.writeShellApplication {
      name = "ad";
      runtimeInputs = [ pkgs.neovide ];
      text = ''
        export NVIM_APPNAME="astronvim-v5"
        exec ${pkgs.neovide}/bin/neovide "$@"
      '';
    })
  ];
}
