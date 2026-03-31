let
  # NOTE: To get the user public key execute cat ~/.ssh/id_ed25519.pub
  # NOTE: To get the host public key execute cat /etc/ssh/ssh_host_ed25519_key.pub
  nekomangini = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKZmGOztlgsKDd1foiIBpQIsMGAdxiWg9TlhSGgwHz1m";
in
{
  "my-paths.age".publicKeys = [
    nekomangini
  ];
}
