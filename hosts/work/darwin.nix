{
  config,
  pkgs,
  username,
  homeDirectory,
  ...
}: let
  go-migrate-mysql = pkgs.go-migrate.overrideAttrs (oldAttrs: {
    tags = ["mysql"];
  });
in {
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
    "/etc/profiles/per-user/${username}/bin"
  ];

  # Enable zsh shell
  programs.zsh.enable = true;

  environment.shells = [
    "/run/current-system/sw/bin/zsh"
  ];

  system.defaults = {
    dock.persistent-apps = [
      "/Applications/Safari.app"
      "/Applications/Feishu.app"
      "/Applications/Ghostty.app"
      "/Applications/Nix Apps/DBeaver.app"
      "/Applications/Surfshark.app"
      "/System/Applications/Utilities/Activity Monitor.app"
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
}
