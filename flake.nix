{
  description = "NixOS configuration with flakes";

  inputs = {
    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations = {
        # desktop
        neko-desktop = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/desktop/configuration.nix

            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";

              # home-manager.users.nekomangini = import ./home.nix;
              home-manager.users.nekomangini = import ./modules/home-manager/profiles/desktop.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };

        # laptop
        neko-laptop = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/laptop/configuration.nix

            # make home-manager as a module of nixos
            # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";

              # home-manager.users.nekomangini = import ./home.nix;
              home-manager.users.nekomangini = import ./modules/home-manager/profiles/laptop.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };
    };
}
