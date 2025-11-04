{ ... }:

{
  # Load uinput kernel module
  boot.kernelModules = [ "uinput" ];

  # Create udev rule for uinput permissions
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Create uinput group
  users.groups.uinput = { };
}
