{
  description = "Based and Minimal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      hjem,
    }@inputs:
    {
      nixosConfigurations.nepsis = nixpkgs.lib.nixosSystem {
        modules = [
          hjem.nixosModules.default
          ./configuration.nix
        ];
      };
    };
}
