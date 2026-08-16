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
    ./git.nix
    ./gnupg.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.${username}.shell = pkgs.zsh;

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
    };
  };

  environment.systemPackages = with pkgs; [
    # Utilities
    ffmpeg
    wget
    curl
    jq
    fastfetch
    pamixer
    btop
    tealdeer

    # Coding
    lazygit
    nixfmt
    tokei
    gcc
    alejandra
    gnumake

    # Nix Utilities
    nh
    nix-output-monitor

    # Networking Utilities
    dig
    wireguard-tools

    # Torrent
    qbittorrent
    proton-vpn-cli
    proton-vpn
  ];

  # Networking
  networking.networkmanager.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["exfat"];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Locale
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];

      # Preference for my own nix bin cache
      substituters = [
        "https://nix-cache.skullheadx.com"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      # trusted pub key for cache.nixos.org not needed because built in
      trusted-public-keys = [
        "nix-cache.skullheadx.com:Nom1Auo0mjFVJGnquoIabtMrMEksqBQEab2RNv0ZnBc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      # Do not use github for the flake registry
      flake-registry = "";
      max-jobs = "auto";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;

    # Replace same dependency with symlinked one to reduce storage usage.
    optimise = {
      automatic = true;
      dates = ["Sun 00:00:00"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      # TODO: Figure out what this does
      persistent = true;
    };
  };

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

  # Required for Steam to work
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
