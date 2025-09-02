{
  description = "Skullheadx's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
    };
    schizofox.url = "github:schizofox/schizofox";
    nur = {
      url = "github:nix-community/NUR";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    nvf,
    schizofox,
    nur,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [nur.overlay];
    };
    skullNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [
        ./neovim.nix
      ];
      extraSpecialArgs = {inherit inputs;};
    };
  in {
    nixosConfigurations = {
      home = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
    homeConfigurations = {
      andrew = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          stylix.homeModules.stylix
          #nur.modules.nixos.default
          ./home.nix
        ];
        extraSpecialArgs = {inherit inputs skullNeovim;};
      };
    };
    packages.${system}.skull-neovim = skullNeovim.neovim;
  };
}
