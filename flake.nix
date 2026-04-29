{
  description = "Based and Minimal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
    }@inputs:
    {
      nixosConfigurations.nepsis = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          hjem.nixosModules.default
          ./configuration.nix
          ./overlays.nix
        ];
      };
    };
}
