{
  description = "Andrew Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util = {
      url = "github:hraban/mac-app-util";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    darwin,
    mac-app-util,
    nur,
    nvf,
    ...
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};

    # Neovim with all languages (personal)
    neovimFull = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [
        {
          config.vim.extraPackages = [];
        }
        (import ./nvf/nvf.nix {
          inherit pkgs;
          enabledLanguages = ["all"];
        })
      ];
    };

    # Neovim with minimal languages (work: js, go, python, markdown, nix)
    neovimWork = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [
        {
          config.vim.extraPackages = [];
        }
        (import ./nvf/nvf.nix {
          inherit pkgs;
          enabledLanguages = ["ts" "go" "python" "markdown" "nix"];
        })
      ];
    };

    # Helper function to create darwin configurations
    mkDarwinConfiguration = {
      hostname,
      username,
      homeDirectory,
      userShell,
      customNeovim,
    }:
      darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs customNeovim username homeDirectory userShell;
        };
        modules = [
          {
            nixpkgs.overlays = [nur.overlays.default];
          }
          ./hosts/${hostname}/default.nix
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          (
            {
              pkgs,
              config,
              ...
            }: {
              home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
              ];

              users.users.${username} = {
                home = homeDirectory;
                shell = userShell;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.overwriteBackup = true;

              home-manager.extraSpecialArgs = {
                inherit customNeovim username homeDirectory;
              };

              home-manager.users.${username} = import ./hosts/${hostname}/home.nix;
            }
          )
        ];
      };
  in {
    formatter.aarch64-darwin = pkgs.nixpkgs-fmt;
    packages.${system} = {
      neovim-full = neovimFull.neovim;
      neovim-work = neovimWork.neovim;
    };

    darwinConfigurations = {
      # Personal laptop configuration
      "Andrews-Laptop" = mkDarwinConfiguration {
        hostname = "personal";
        username = "andrewmontgomery";
        homeDirectory = "/Users/andrewmontgomery/";
        userShell = "/run/current-system/sw/bin/fish";
        customNeovim = neovimFull;
      };

      # Work VM configuration
      "Work-VM" = mkDarwinConfiguration {
        hostname = "work";
        username = "andrewmontgomery";
        homeDirectory = "/Users/andrewmontgomery/";
        userShell = "/run/current-system/sw/bin/zsh";
        customNeovim = neovimWork;
      };
    };
  };
}
