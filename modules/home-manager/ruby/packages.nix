{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ruby
    postgresql
    sqlite
    yarn
  ];
}
