{
  description = "Based and Minimal Flake For Darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem = {
      url = "github:feel-co/hjem";
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
    nix-darwin,
    home-manager,
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
    nixosConfigurations.nepsis = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs nvim;};
      modules = [
        hjem.nixosModules.default
        ./linux-common.nix
        ./hosts/nepsis/configuration.nix
        ./overlays.nix
      ];
    };
    nixosConfigurations.icon = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs nvim;};
      modules = [
        hjem.nixosModules.default
        ./linux-common.nix
        ./hosts/icon/configuration.nix
        ./overlays.nix
      ];
    };

    packages.${system}.nvim = nvim.neovim;
    packages.${system-darwin}.nvim = nvim-darwin.neovim;

    darwinConfigurations = {
      kenosis = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          nvim = nvim-darwin;
        };
        modules = [
          ./darwin-common.nix
          ./hosts/kenosis/configuration.nix
          ./overlays.nix
          home-manager.darwinModules.home-manager
          {
            users.users.andrew = {
              home = /Users/andrew;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.andrew = {
              imports = [./home.nix];
              home.username = "andrew";
              home.homeDirectory = /Users/andrew;
            };
          }
        ];
      };
      bear = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs;
          nvim = nvim-darwin;
        };
        modules = [
          ./darwin-common.nix
          ./hosts/bear/configuration.nix
          ./overlays.nix
          home-manager.darwinModules.home-manager
          {
            users.users.andrewmontgomery = {
              home = /Users/andrewmontgomery;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
            home-manager.users.andrewmontgomery = {
              imports = [./home.nix];
              home.username = "andrewmontgomery";
              home.homeDirectory = /Users/andrewmontgomery;
            };
          }
        ];
      };
    };
  };
}
