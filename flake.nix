{
  description = "Based and Minimal Flake For Darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
	inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };
  outputs = {
    self,
    nixpkgs,
    nix-darwin,
nvf,
  } @ inputs:
  let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};

    customNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./nvf/nvf.nix];
    };
in
 {
    packages.${system}.my-neovim = customNeovim.neovim;
    darwinConfigurations."kenosis" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        ./overlays.nix
      ];

      specialArgs = {
        inherit customNeovim;
      };
    };
  };
}
