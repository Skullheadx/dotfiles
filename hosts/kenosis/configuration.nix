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
  # Primary user for user-specific settings (dock, etc.)
  system.primaryUser = "andrew";
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

    codex
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

  homebrew = {
    enable = true;
    user = "andrew";

    taps = [
    ];
    brews = [
      "openssh"
      "redis"
    ];
    casks = [
      "keepingyouawake"
      "feishu"
      "surfshark"
      "scroll-reverser"
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
