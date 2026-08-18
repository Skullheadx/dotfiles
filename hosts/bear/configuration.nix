{
  config,
  pkgs,
  pkgs-nixos-26,
  inputs,
  nvim,
  ips,
  username,
  ...
}: {
  imports = [
    ./../../hjem-darwin.nix
  ];

  networking = {
    computerName = "bear";
    hostName = "bear";
    localHostName = "bear";
  };

  # Primary user for user-specific settings (dock, etc.)
  system.primaryUser = username;

  environment.systemPackages = with pkgs;
    [
      mpv
      qbittorrent
      proton-vpn-cli
    ]
    ++ (with pkgs-nixos-26; [
      audacity
    ]);

  homebrew = {
    enable = true;
    user = username;

    taps = [
    ];
    brews = [
    ];
    casks = [
      "protonvpn"
      "selfcontrol"
      "kdenlive"
      "steam"
    ];
  };

  # Dock configuration
  system.defaults.dock = {
    persistent-apps = [
      "/System/Applications/Reminders.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/Music.app"
      "/System/Applications/Messages.app"

      "/Applications/Ghostty.app"
      "/Applications/Nix Apps/LibreWolf.app"

      "/System/Applications/System Settings.app"
    ];
  };

  programs.ssh = {
    knownHosts = {
      homelab = {
        extraHostNames = [ips.ip_local_homelab];
        publicKeyFile = ./../../pubkeys/homelab_ssh.pub;
      };
      desktop = {
        extraHostNames = [ips.ip_local_desktop];
        publicKeyFile = ./../../pubkeys/desktop_ssh.pub;
      };
      vps = {
        extraHostNames = [ips.ip_pub_vps];
        publicKeyFile = ./../../pubkeys/vps_ssh.pub;
      };
      github = {
        extraHostNames = ["github.com"];
        publicKeyFile = ./../../pubkeys/github_ssh.pub;
      };
    };
    extraConfig = ''
      Host homelab
        HostName ${ips.ip_local_homelab}
        Port 22
        User andrew
      Host vps
        Hostname ${ips.ip_pub_vps}
        Port 2222
        User andrew
      Host router
        Hostname ${ips.ip_local_router}
        Port 2222
        User andrew
      Host desktop
        HostName ${ips.ip_local_desktop}
        Port 22
        User andrew
    '';
  };

  # IMPORTANT Update this in all other hosts if changed
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     PasswordAuthentication = false;
  #     KbdInteractiveAuthentication = false;
  #
  #     PermitRootLogin = "no";
  #
  #     PubkeyAuthentication = "yes";
  #     # MaxAuthTries = 3;
  #     # LoginGraceTime = "30s";
  #
  #     # X11Forwarding = false;
  #     # AllowAgentForwarding = false;
  #     # AllowTcpForwarding = true;
  #   };
  #   ports = [2222];
  # };
}
