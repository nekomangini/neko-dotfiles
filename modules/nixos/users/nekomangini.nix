{ pkgs, ... }:

{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nekomangini = {
    isNormalUser = true;
    description = "encar salazar";
    shell = pkgs.fish;

    # NOTE LAPTOP(VOID LINUX)
    # Maaaaaa! pa void
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKOlwmNBZHDXRpqpneubWYPGtMZaa2X+Fr5BMuzmkEOq nekomangini.dev@gmail.com"
    ];
  };
}
