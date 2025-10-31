{ pkgs, ... }:

{
  programs.fish.shellAliases = {
    ls = "${pkgs.eza}/bin/eza -l --header --icons";
    lg = "${pkgs.lazygit}/bin/lazygit";
    ff = "${pkgs.fastfetch}/bin/fastfetch";
  };
}
