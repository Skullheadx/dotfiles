{
  description = "Based and Minimal Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-slstatus = {
      url = "git://git.skullheadx.com/slstatus.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-surf = {
      url = "git://git.skullheadx.com/surf.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-dwm = {
      url = "git://git.skullheadx.com/dwm.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-st = {
      url = "git://git.skullheadx.com/st.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-dmenu = {
      url = "git://git.skullheadx.com/dmenu.git";
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
    hjem,
    my-slstatus,
    my-surf,
    my-dwm,
    my-st,
    my-dmenu,
    nvf,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    customNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./nvf/nvf.nix];
    };
  in {
    nixosConfigurations.nepsis = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs customNeovim;};
      modules = [
        hjem.nixosModules.default
        ./linux-common.nix
        ./hosts/nepsis/configuration.nix
        ./overlays.nix
      ];
    };
    nixosConfigurations.icon = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs customNeovim;};
      modules = [
        hjem.nixosModules.default
        ./linux-common.nix
        ./hosts/icon/configuration.nix
        ./overlays.nix
      ];
    };

    packages.${system}.my-neovim = customNeovim.neovim;
  };
}
