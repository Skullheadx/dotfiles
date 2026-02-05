{
  config,
  pkgs,
  inputs,
  ...
}: let
  go-migrate-mysql = pkgs.go-migrate.overrideAttrs (oldAttrs: {
    tags = ["mysql"];
  });
in {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # work tools
    go
    go-migrate-mysql
    jdk17
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
      google-cloud-sdk.components.pubsub-emulator
      google-cloud-sdk.components.beta
    ])
    nodejs
    yarn
    kubectl
    ffmpeg
    dbeaver-bin
    ngrok

    claude-code
    air
  ];

  environment.systemPath = [
    "/etc/profiles/per-user/andrewmontgomery/bin"
  ];
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;
  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };

  # services.aerospace = {
  #       enable = true;
  # };

  # services.jankyborders = {
  #       enable = true;
  #       hidpi = true;
  #  active_color="0xffe2e2e3";
  #  inactive_color="0xff414550";
  #  style  = "round";
  # };

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
        autohide = false;
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
        location = "/Users/andrewmontgomery/Documents/Screenshots";
        type = "jpg";
      };
    };

    keyboard = {
      remapCapsLockToEscape = true;
      swapLeftCtrlAndFn = true;
      enableKeyMapping = true;
    };
  };

  environment.shells = [
    "/run/current-system/sw/bin/zsh"
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    user = "andrewmontgomery";

    taps = [
    ];
    brews = [
      "openssh"
      "redis"
    ];
    casks = [
      "keepingyouawake"
      "ghostty"
      "feishu"
      "surfshark"
      "scroll-reverser"
    ];
  };

  # Primary user for user-specific settings (dock, etc.)
  system.primaryUser = "andrewmontgomery";

  # Dock configuration
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Safari.app"
      "/Applications/Feishu.app"
      "/Applications/Ghostty.app"
      "/Applications/Nix Apps/DBeaver.app"
      "/Applications/Surfshark.app"
      "/System/Applications/Utilities/Activity Monitor.app"
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # nixpkgs.config.allowUnsupportedSystem = true;
  power.sleep.display = "never";
}
