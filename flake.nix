{
  description = "Based and Minimal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-slstatus = {
      url = "github:Skullheadx/slstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-surf = {
      url = "github:Skullheadx/surf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-dwm = {
      url = "github:Skullheadx/dwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-st = {
      url = "github:Skullheadx/st";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-dmenu = {
      url = "github:Skullheadx/dmenu";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      hjem,
      my-slstatus,
      my-surf,
      my-dwm,
      my-st,
      my-dmenu,
      nvf,
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      customNeovim = nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ ./nvf/nvf.nix ];
      };
    in
    {
      nixosConfigurations.nepsis = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs customNeovim; };
        modules = [
          hjem.nixosModules.default
          ./configuration.nix
          ./overlays.nix
        ];
      };

      packages.${system}.my-neovim = customNeovim.neovim;
    };
}
