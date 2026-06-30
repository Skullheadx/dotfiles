{
  config,
  pkgs,
  inputs,
  nvim,
  username,
  ...
}: {
  imports = [
    # ./legacy.nix
    ./../../hjem-darwin.nix
  ];

  networking = {
    computerName = "kenosis";
    hostName = "kenosis";
    localHostName = "kenosis";
  };
  # Primary user for user-specific settings (dock, etc.)
  system.primaryUser = username;

  programs.ssh = {
    knownHosts = {
      homelab = {
        extraHostNames = ["192.168.1.120"];
        publicKeyFile = ./../../pubkeys/homelab_ssh.pub;
      };
      desktop = {
        extraHostNames = ["192.168.1.122"];
        publicKeyFile = ./../../pubkeys/desktop_ssh.pub;
      };
      vps = {
        extraHostNames = ["170.205.37.7"];
        publicKeyFile = ./../../pubkeys/vps_ssh.pub;
      };
      github = {
        extraHostNames = ["github.com"];
        publicKeyFile = ./../../pubkeys/github_ssh.pub;
      };
    };
    extraConfig = ''
      Host git-vps
        HostName git.skullheadx.com
        Port 2222
        User git
      Host git.skullheadx.com
        HostName localhost
        Port 2223
        User git
        ProxyJump git-vps
      Host homelab
        HostName 192.168.1.120
        Port 22
      Host vps
        Hostname 170.205.37.7
        Port 2222
    '';
  };
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
    user = username;

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
      "docker-desktop"
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
