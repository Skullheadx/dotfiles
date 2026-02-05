{
  config,
  pkgs,
  username,
  homeDirectory,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vim
    brave
    discord
    utm
    audacity
    zig
    typst
  ];

  environment.systemPath = [
    "/etc/profiles/per-user/${username}/bin"
  ];

  # Enable fish shell
  programs.fish.enable = true;

  environment.shells = [
    "/run/current-system/sw/bin/fish"
  ];

  system.defaults = {
    dock.persistent-apps = [
      "/System/Applications/Reminders.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/Music.app"
      "/System/Applications/Messages.app"
      "/Applications/KeePassXC.app"
      "/Applications/Ghostty.app"
      "/Applications/LibreWolf.app"
      "/Applications/Nix Apps/UTM.app"
      "/System/Applications/System Settings.app"
    ];

    screencapture = {
      location = "${homeDirectory}Documents/Screenshots";
      type = "jpg";
    };
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    user = username;
    taps = [];
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
}
