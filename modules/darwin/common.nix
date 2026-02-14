{
  config,
  pkgs,
  username,
  ...
}: {
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Touch ID for sudo
  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };

  system = {
    # Used for backwards compatibility
    stateVersion = 6;
    primaryUser = username;

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
    };

    keyboard = {
      remapCapsLockToEscape = true;
      swapLeftCtrlAndFn = true;
      enableKeyMapping = true;
    };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  power.sleep.display = "never";
}
