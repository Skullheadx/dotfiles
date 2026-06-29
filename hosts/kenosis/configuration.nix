{
  config,
  pkgs,
  inputs,
  nvim,
  ...
}: {
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
    # work tools
    go
    jdk17
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
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
    lazygit
    fastfetch
    nvim.neovim
    git
    go-swag
    blender
    (python313.withPackages (ps:
      with ps; [
        numpy
      ]))
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
      "google-chrome"
      "firefox"
      "chatgpt"
      "capcut"
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
