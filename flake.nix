{
  description = "Based and Minimal Flake For Darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    hjem,
    nix-darwin,
  } @ inputs: {
    darwinConfigurations."kenosis" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        hjem.nixosModules.default
        ./configuration.nix
        ./overlays.nix
      ];
    };
  };
}
