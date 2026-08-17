{
  config,
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [
    ./zsh-darwin.nix
    ./vim.nix
    ./irc.nix
    ./gnupg-darwin.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  environment.systemPackages = with pkgs; [
    # Utilities
    ffmpeg
    wget
    curl
    jq
    fastfetch
    btop
    tealdeer
    imagemagick

    # Coding
    lazygit
    delta
    git
    tokei
    gcc
    alejandra
    gnumake

    ## Nix tools
    nh
    nix-output-monitor

    # User tools
    ## Password management
    pass
    passExtensions.pass-otp
    passExtensions.pass-update

    librewolf
  ];

  nix.gc = {
    automatic = true;
    interval.Day = 7;
    options = "--delete-older-than 14d";
  };

  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.fira-code
  ];

  security.sudo.extraConfig = ''
    Defaults timestamp_type=global
    Defaults timestamp_timeout=60
  '';
  security.pam.services.sudo_local = {
    enable = false;
    reattach = false;
    touchIdAuth = false;
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        NSAutomaticCapitalizationEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSWindowShouldDragOnGesture = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
      };

      controlcenter.NowPlaying = true;

      dock = {
        minimize-to-application = true;
        mru-spaces = false;
        show-recents = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowMountedServersOnDesktop = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXEnableColumnAutoSizing = true;
        _FXSortFoldersFirst = true;
      };

      screencapture = {
        location = "/Users/${username}/Documents/Screenshots";
        type = "jpg";
      };
    };

    keyboard = {
      remapCapsLockToEscape = true;
      swapLeftCtrlAndFn = true;
      enableKeyMapping = true;
    };
  };

  homebrew = {
    enable = true;
    # onActivation.cleanup = "uninstall";

    taps = [
    ];
    brews = [
    ];
    casks = [
      "keepingyouawake"
      "scroll-reverser"
      "ghostty"
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
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
  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
    nixpkgs-nixos-26.flake = inputs.nixpkgs-nixos-26;
  };
  nix.optimise = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
  };
}
