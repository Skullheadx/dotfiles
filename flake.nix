{
  description = "Andrew Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.11";
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur = {
      url = "github:nix-community/NUR";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{  nixpkgs, home-manager, darwin, nur, ... }: 
    # let 
    #    pkgs-stable = nixpkgs-stable.legacyPackages."aarch64-darwin";
    # in 
      {
    darwinConfigurations."Andrews-Laptop" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {

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
            # home-manager.extraSpecialArgs = [ inputs ];
          }
        ];
      };
  };
}
