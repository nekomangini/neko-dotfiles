{ ... }:

# Auto mounts the hdd
{
  fileSystems."/mnt/D" = {
    device = "/dev/disk/by-uuid/50b9c21e-f26e-464b-909b-a38a86929457";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };
}
