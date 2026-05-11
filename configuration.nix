{
  config,
  pkgs,
  inputs,
  customNeovim,
  ...
}: let
  go-migrate-mysql = pkgs.go-migrate.overrideAttrs (oldAttrs: {
    tags = ["mysql"];
  });
in {
  networking = {
    computerName = "kenosis";
    hostName = "kenosis";
    localHostName = "kenosis";
  };

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
    pnpm
    librewolf
    brave
    lazygit
    fastfetch
    customNeovim.neovim
    git
  ];

  environment.systemPath = [
    "/etc/profiles/per-user/andrew/bin"
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
        location = "/Users/andrew/Documents/Screenshots";
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
    user = "andrew";

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
  system.primaryUser = "andrew";

  # Dock configuration
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Nix Apps/Librewolf.app"
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
