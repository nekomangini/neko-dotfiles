{ pkgs, ... }:
{
  # Desktop-specific groups and packages
  users.users.nekomangini = {
    extraGroups = [
      "networkmanager"
      "wheel"
      "input" # For ydotool
      "uinput" # For ydotool
    ];
    packages = with pkgs; [
      clang
      cmake
      gcc
      gnumake

      clojure
      leiningen
      clj-kondo

      nodejs_22
      typescript

      # jdk24 # EOF
      jdk21_headless

      rakudo
    ];
  };
}
