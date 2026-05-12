{
  description = "Based and Minimal Flake For Darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    nvf,
  } @ inputs: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};

    customNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./nvf/nvf.nix];
    };
    mkDarwin = hostname:
      nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs customNeovim hostname;};
        modules = [
          ./darwin-common.nix
          ./hosts/${hostname}/configuration.nix
          ./overlays.nix
        ];
      };
  in {
    packages.${system}.my-neovim = customNeovim.neovim;
    darwinConfigurations = {
      kenosis = mkDarwin "kenosis";
      angel = mkDarwin "angel";
    };
  };
}
