# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/polkit-rules.nix
    ./modules/users.nix
    ../../modules/nixos/users
    ../../modules/nixos/core/boot.nix
    ../../modules/nixos/core/locale.nix
    ../../modules/nixos/core/fonts.nix
    ../../modules/nixos/core/network.nix
    ../../modules/nixos/core/nixsetting.nix

    ../../modules/nixos/hardware/audio.nix
    ../../modules/nixos/hardware/nvidia.nix

    ../../modules/nixos/services/syncthing.nix
    ../../modules/nixos/services/flatpak.nix
    ../../modules/nixos/services/printing.nix
    ../../modules/nixos/services/touchpad.nix

    ../../modules/nixos/desktop/plasma.nix
    ../../modules/nixos/desktop/xserver.nix

    ../../modules/nixos/window-managers/hyprland.nix
    ../../modules/nixos/window-managers/qtile.nix

    ../../modules/nixos/programs/fish.nix
    ../../modules/nixos/programs/adb.nix

    ../../modules/nixos/users

    ../../modules/nixos/development/android.nix

    ../../modules/nixos/maintenance/autoupdate.nix

    ../../modules/nixos/hardware/ydotools.nix
  ];

  networking.hostName = "neko-desktop"; # Define your hostname.

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    polkit
    kdePackages.polkit-kde-agent-1

    brave
    vivaldi

    # System tools
    # git
    xdg-utils

    # programming #
    clojure
    leiningen
    clj-kondo

    jdk24

    nodejs_22
    typescript

    rakudo

    clang
    cmake
    gcc
    gnumake
    # end programming #

    # art #
    (blender.override { cudaSupport = true; })
    krita
    kdePackages.gwenview
    # end art #

    # terminal #
    neovim
    tmux

    hyprshot
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
