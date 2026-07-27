{
  config,
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [
    ./bash.nix
    ./zsh-linux.nix
    ./irc.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["exfat"];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = [
      "https://nix-cache.skullheadx.com"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-cache.skullheadx.com:Nom1Auo0mjFVJGnquoIabtMrMEksqBQEab2RNv0ZnBc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    flake-registry = "";
    max-jobs = "auto";
  };
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.optimise = {
    automatic = true;
    dates = ["Sun 00:00:00"];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    persistent = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ffmpeg

    wget
    curl
    jq

    lazygit
    fastfetch
    pamixer
    btop
    tealdeer
    tokei

    nixfmt
    gcc
    alejandra
    gnumake

    nh
    nix-output-monitor
  ];

  fonts = {
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Fira Code Nerd Font"];
        sansSerif = ["Fira Sans"];
      };
      hinting = {
        autohint = false;
        enable = true;
        style = "slight";
      };
    };
    packages = with pkgs; [
      fira-code
      nerd-fonts.fira-code
    ];
  };

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Skullheadx";
        email = "andrew@montgomery.systems";
      };
      pull.rebase = true;
      url = {
        "git@github.com:".insteadOf = "https://github.com/";
      };
    };
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  environment.sessionVariables = {
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services
  services.openssh.enable = true;
  services.rsync = {
    enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
