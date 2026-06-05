{ pkgs, ... }:

{
  programs.fish.shellAliases = {
    ls = "${pkgs.eza}/bin/eza -l --header --icons";
    lg = "${pkgs.lazygit}/bin/lazygit";
    ff = "${pkgs.fastfetch}/bin/fastfetch";
    # up = "uptime | awk '{print $3}' | tr -d ','";
    up = "${pkgs.fastfetch}/bin/fastfetch --logo none --structure uptime";
  };
}
