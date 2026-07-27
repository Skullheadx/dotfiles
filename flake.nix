{
  description = "A minimal Suckless-inspired Flake for NixOS and Nix Darwin, created by Skullheadx.";

  inputs = {
    nixpkgs.url = "git://git.skullheadx.com/nixpkgs.git";
    nixpkgs-nixos-26.url = "git://git.skullheadx.com/nixpkgs.git?ref=refs/heads/nixos-26.05";
    nix-darwin = {
      url = "git://git.skullheadx.com/nix-darwin.git";
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
      url = "git://git.skullheadx.com/nvf.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        mnw.follows = "mnw";
        flake-compat.follows = "flake-compat";
      };
    };

    mnw = {
      url = "git://git.skullheadx.com/mnw.git";
    };
    flake-compat = {
      url = "git://git.skullheadx.com/flake-compat.git";
      flake = false;
    };

    hjem = {
      url = "git://git.skullheadx.com/hjem.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-nixos-26,
    hjem,
    my-slstatus,
    my-surf,
    my-dwm,
    my-st,
    my-dmenu,
    nvf,
    nix-darwin,
    mnw,
    flake-compat,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    nvim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./nvf/nvf.nix];
    };

    system-darwin = "aarch64-darwin";
    pkgs-darwin = nixpkgs.legacyPackages.${system-darwin};
    nvim-darwin = nvf.lib.neovimConfiguration {
      pkgs = pkgs-darwin;
      modules = [./nvf/nvf.nix];
    };
  in {
    packages.${system}.nvim = nvim.neovim;
    packages.${system-darwin}.nvim = nvim-darwin.neovim;

    nixosConfigurations = {
      nepsis = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs nvim;
          username = "andrew";
        };
        modules = [
          hjem.nixosModules.default
          ./common-linux.nix
          ./hosts/nepsis/configuration.nix
          ./overlays.nix
        ];
      };
      icon = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs nvim;
          username = "andrew";
        };
        modules = [
          hjem.nixosModules.default
          ./common-linux.nix
          ./hosts/icon/configuration.nix
          ./overlays.nix
        ];
      };
    };

    darwinConfigurations = {
      kenosis = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          nvim = nvim-darwin;
          username = "andrew";
          pkgs-nixos-26 = nixpkgs-nixos-26.legacyPackages.${system-darwin};
        };
        modules = [
          ./common-darwin.nix
          ./hosts/kenosis/configuration.nix
          ./overlays.nix
          hjem.darwinModules.default
        ];
      };
      bear = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          nvim = nvim-darwin;
          username = "andrewmontgomery";
          pkgs-nixos-26 = nixpkgs-nixos-26.legacyPackages.${system-darwin};
        };
        modules = [
          ./common-darwin.nix
          ./hosts/bear/configuration.nix
          ./overlays.nix
          hjem.darwinModules.default
        ];
      };
    };
  };
}
