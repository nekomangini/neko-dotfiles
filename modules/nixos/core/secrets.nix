{
  age = {
    # identityPaths = [ "/home/nekomangini/.ssh/id_ed25519" ]; # requires passphrase
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; # no passphrase
    secrets = {
      "homepage.env" = {
        file = ../../../secrets/homepage.env.age;
        owner = "nekomangini";
      };
    };
  };
}
