{ pkgs, ... }:

{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nekomangini = {
    isNormalUser = true;
    description = "encar salazar";
    shell = pkgs.fish;
  };
}
