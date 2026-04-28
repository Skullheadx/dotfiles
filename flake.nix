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

  };
  outputs =
    {
      self,
      nixpkgs,
      hjem,
      my-slstatus,

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
