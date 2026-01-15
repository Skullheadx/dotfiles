{ config, pkgs, inputs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [ 
                  vim
                  neovim
                  babelfish
                  brave
                  firefox
                  discord
            zig
            zls
            utm

        ] ;

      environment.systemPath = [
      "/etc/profiles/per-user/andrewmontgomery/bin"
      ];
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.

  programs.fish.enable = true;

  environment.shells = [
    "/run/current-system/sw/bin/fish"
  ];


      homebrew = {
            enable = true;
            user = "andrewmontgomery";

    taps = [
    ];
            brews = [
                  "openssh"
            ];
            casks = [
                  "freetube"
                  "protonvpn"
                  "minecraft"
                  "prismlauncher"
                  "keepingyouawake"
                  "keepassxc"
                  "ghostty"
                  "steam"
                  "feishu"
                  "discord"
                  
            ];
      };

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;

      # nixpkgs.config.allowUnsupportedSystem = true;

    }
 
