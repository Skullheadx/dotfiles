{
  config,
  pkgs,
  inputs,
  nvim,
  ...
}: {
  imports = [
    # ./legacy.nix
  ];

  networking = {
    computerName = "kenosis";
    hostName = "kenosis";
    localHostName = "kenosis";
  };
  # Primary user for user-specific settings (dock, etc.)
  system.primaryUser = "andrew";
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    go
    nodejs
    yarn
    kubectl
    ffmpeg
    dbeaver-bin

    claude-code
    air
    pnpm
    librewolf
    lazygit
    fastfetch
    git
    go-swag
    blender
    temporal-cli
    corepack
    (python313.withPackages (ps:
      with ps; [
        numpy
      ]))
    imagemagick
    audacity
    goose
  ];

  homebrew = {
    enable = true;
    user = "andrew";

    taps = [
    ];
    brews = [
    ];
    casks = [
      "feishu"
      "surfshark"
      "google-chrome"
      "firefox"
      "chatgpt"
      "capcut"
      "docker"
      "musicbrainz-picard"
      "gimp"
    ];
  };

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
}
