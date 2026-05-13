{
  config,
  pkgs,
  inputs,
  customNeovim,
  ...
}: {
  # Primary user for user-specific settings (dock, etc.)
  system.primaryUser = "andrew";
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    customNeovim.neovim
    utm
  ];

  homebrew = {
    enable = true;
    user = "andrew";

    taps = [
    ];
    brews = [
    ];
    casks = [
      "keepassxc"
      "protonvpn"
      "selfcontrol"
      "kdenlive"
      "audacity"
    ];
  };
  # Dock configuration
  system.defaults.dock = {
    persistent-apps = [
      "/System/Applications/Reminders.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/Music.app"
      "/System/Applications/Messages.app"

      "/Applications/KeePassXC.app"
      "/Applications/Ghostty.app"
      # "/Applications/Nix Apps/Brave Browser.app"
      "/Applications/Nix Apps/LibreWolf.app"
      # "/Applications/Nix Apps/UTM.app"

      "/System/Applications/System Settings.app"
    ];
  };
}
