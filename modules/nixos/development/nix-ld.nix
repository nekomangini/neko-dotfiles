{ pkgs, ... }:

{

  # FOR FLUTTER DEVELOPMENT
  # Enable nix-ld for running non-NixOS binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add libraries needed by Android tools
    # Standard C/C++ libraries
    zlib
    stdenv.cc.cc.lib

    # Terminal libraries
    ncurses5

    # Graphics
    libGL

    # Audio
    libpulseaudio
  ];
}
