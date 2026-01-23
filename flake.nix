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
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, mac-app-util, ... }:
    # let 
    #    pkgs-stable = nixpkgs-stable.legacyPackages."aarch64-darwin";
    # in   
    let
      pkgs = import nixpkgs { system = "aarch64-darwin"; };
    in
    {

      formatter.aarch64-darwin = pkgs.nixpkgs-fmt;
      darwinConfigurations."Andrews-Laptop" = darwin.lib.darwinSystem {
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
            home-manager.users.andrewmontgomery = ./home.nix;
            home-manager.backupFileExtension = "bak";
            home-manager.overwriteBackup = true;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
            # home-manager.extraSpec ialArgs = [ inputs ];
          })
        ];
      };
    };
}
