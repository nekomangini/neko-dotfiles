let
  # NOTE: To get the host public key execute cat /etc/ssh/ssh_host_ed25519_key.pub
  nekomangini = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK3G7EA0RM76fW1QA3eRrT+Kohxsh58IG47gonzCM+VQ";
in
{
  "my-paths.age".publicKeys = [ nekomangini ];
  "note-path.age".publicKeys = [ nekomangini ];
}
