{
  age = {
    # identityPaths = [ "/home/nekomangini/.ssh/id_ed25519" ]; # requires passphrase
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # no passphrase
    secrets = {
      tmux-manager-paths = {
        file = ../../../secrets/tmux-manager-paths.age;
        owner = "nekomangini";
      };
      note-path = {
        file = ../../../secrets/note-path.age;
        owner = "nekomangini";
      };
    };
  };
}
