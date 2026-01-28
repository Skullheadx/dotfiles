{
  description = "Andrew Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util = {
      url = "github:hraban/mac-app-util"; 
    inputs.nixpkgs.follows = "nixpkgs";};
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    darwin,
    mac-app-util,
    nvf,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};

    customNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./nvf/nvf.nix];
    };
  in {
    formatter.aarch64-darwin = pkgs.nixpkgs-fmt;
    packages.${system}.my-neovim = customNeovim.neovim;
    darwinConfigurations."andrewmontgomerys-Virtual-Machine" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [

          ./configuration.nix
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager(
          {pkgs, config, inputs, ...}:
          {
 home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
              ];

            users.users."andrewmontgomery" = {
              home = "/Users/andrewmontgomery/";

              shell = "/run/current-system/sw/bin/fish";
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.overwriteBackup = true;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
            # home-manager.extraSpec ialArgs = [ inputs ];
            home-manager.extraSpecialArgs = {customNeovim = customNeovim;};
          })
        ];
      };
    };
  };
}
