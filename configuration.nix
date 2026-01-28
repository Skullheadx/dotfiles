{
  config,
  pkgs,
  inputs,
  ...
}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    babelfish
    brave
    # firefox
    discord
    zig
    zls
    utm
    sqlite
    dbeaver-bin
    uv
    lazygit
    ngrok
    audacity
  ];

  environment.systemPath = [
    "/etc/profiles/per-user/andrewmontgomery/bin"
  ];
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.

  programs.fish.enable = true;
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
  system.defaults.NSGlobalDomain.AppleICUForce24HourTime = true;
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;

  system.defaults.controlcenter.NowPlaying = true;

  system.defaults.dock = {
    autohide = false;
    minimize-to-application = true;
    mru-spaces = false;
    show-recents = false;
    persistent-apps = [
      "/System/Applications/Reminders.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/Music.app"
      "/System/Applications/Messages.app"

      "/Applications/KeePassXC.app"
      "/Applications/Ghostty.app"
      # "/Applications/Nix Apps/Brave Browser.app"
      "/Applications/LibreWolf.app"
      "/Applications/Nix Apps/UTM.app"

      "/System/Applications/System Settings.app"
    ];
  };
  system.defaults.finder = {
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

  system.defaults.screencapture.location = "/Users/andrewmontgomery/Documents/Screenshots";
  system.defaults.screencapture.type = "jpg";
  system.keyboard.remapCapsLockToEscape = true;
  system.keyboard.swapLeftCtrlAndFn = true;
  environment.shells = [
    "/run/current-system/sw/bin/fish"
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    user = "andrewmontgomery";

    taps = [
    ];
    brews = [
      "openssh"
    ];
    casks = [
      "selfcontrol"
      "keepingyouawake"
      "freetube"
      "protonvpn"
      "keepassxc"
      "ghostty"
      "steam"
      "discord"
      "corretto@11" # java runtime for matlab
      "scroll-reverser"
      "librewolf"
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
  system.primaryUser = "andrewmontgomery";

  programs.direnv = {
    enable = true;
    # enableFishIntegration = true;
  };
  system.keyboard.enableKeyMapping = true;
}
