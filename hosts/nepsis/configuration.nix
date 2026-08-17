{
  config,
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./x11.nix
    ./../../audio-linux.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [];
  };

  hjem.users.${username} = {
    directory = "/home/${username}";
    files = {
      ".config/surf/styles/default.css".source = ../../dotfiles/surf/styles/default.css;
      ".config/surf/script.js".source = ../../dotfiles/surf/script.js;

      ".sfeed/sfeedrc".source = ../../dotfiles/sfeed/sfeedrc;

      ".config/fastfetch/config.jsonc".source = ../../dotfiles/fastfetch/config.jsonc;
      ".config/lazygit/config.yml".source = ../../dotfiles/lazygit/config.yml;
      ".config/tealdeer/config.toml".source = ../../dotfiles/tealdeer/config.toml;
      ".config/sxhkd/sxhkdrc".text = builtins.readFile (
        pkgs.replaceVars ../../dotfiles/sxhkd/sxhkdrc {
          dmenu = pkgs.dmenu;
          st = pkgs.st;
          surf = pkgs.surf;
          pamixer = pkgs.pamixer;
          maim = pkgs.maim;
          xdotool = pkgs.xdotool;
          xclip = pkgs.xclip;
          lockscreen = pkgs.lock-screen;
          sfeed = pkgs.sfeed;
          rmpc = pkgs.rmpc;
          mpc = pkgs.mpc;
          librewolf = pkgs.librewolf;
        }
      );
    };

    packages = with pkgs; [
      librewolf
      mpv
      zathura
      lf
      sfeed
      gimp
    ];
  };

  systemd.user.services."sfeed-update" = {
    description = "Update sfeed RSS feeds";
    path = with pkgs; [
      curl
      sfeed
      coreutils
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.sfeed}/bin/sfeed_update";
    };
  };

  systemd.user.timers."sfeed-update" = {
    description = "Run sfeed_update daily";
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
    wantedBy = ["timers.target"];
  };

  environment.systemPackages = with pkgs; [
    # System
    feh
    pamixer
    xdotool
    bat

    # Screenshot
    maim
    slop
    xclip

    yt-dlp

    pass
    passExtensions.pass-otp
    passExtensions.pass-update
    passExtensions.pass-import

    # Ensure that you set the environment.sessionVariables
    bibata-cursors

    # Productivity
    libreoffice-fresh
    kdePackages.kdenlive
    obs-studio

    # Programming
    zig
    typst
    (python314.withPackages (ps:
      with ps; [
        opencv4
      ]))
  ];

  # TODO: Setup Firefox Config https://search.nixos.org/options?channel=unstable&query=programs.firefox&type=options
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = [pkgs.passff-host];
    package = pkgs.librewolf;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  environment.sessionVariables = {
    BROWSER = "surf";
    SFEED_PLUMBER = "$BROWSER";
    SFEED_URL_FILE = "$HOME/.local/share/sfeed/sfeed_read_url_file";
    XCURSOR_SIZE = 25;
    XCURSOR_THEME = "Bibata-Modern-Ice";
  };

  # Homelab NFS
  fileSystems."/mnt/data" = {
    device = "192.168.1.120:/";
    fsType = "nfs4";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "rw"
    ];
    # TODO: Setup the user permissions, so that MacOS can access files from linux
  };

  # IMPORTANT Update this in all other hosts if changed
  services.openssh = {
    enable = true;
    enableRecommendedAlgorithms = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;

      PermitRootLogin = "no";
      PubkeyAuthentication = "yes";
      # MaxAuthTries = 3;
      # LoginGraceTime = "30s";

      # X11Forwarding = false;
      # AllowAgentForwarding = false;
      # AllowTcpForwarding = true;
    };
    ports = [2222];
  };

  programs.ssh = {
    knownHosts = {
      homelab = {
        extraHostNames = ["192.168.1.120"];
        publicKeyFile = ./../../pubkeys/homelab_ssh.pub;
      };
      laptop = {
        extraHostNames = ["192.168.1.111"];
        publicKeyFile = ./../../pubkeys/laptop_ssh.pub;
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
      Host homelab
        HostName 192.168.1.120
        Port 22
      Host vps
        Hostname 170.205.37.7
        Port 2222
      Host router
        Hostname 192.168.1.115
        Port 2222
      Host builder
        HostName 192.168.1.120
        StrictHostKeyChecking=accept-new
        IdentitiesOnly yes
        IdentityFile /root/.ssh/nixremote
        User nixremote
    '';
  };

  networking = {
    hostName = "nepsis";

    # Uses the homelab for DNS Nameservers
    # TODO: Think about DNS resolving from outside through homelab
    networkmanager.dns = "none";
    nameservers = ["192.168.1.120"];
    useDHCP = false;

    # Block certain websites
    # extraHosts = ''
    #   0.0.0.0 youtube.com
    #   0.0.0.0 www.youtube.com
    #   0.0.0.0 www.youtu.be
    # '';

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];

    # TODO: Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # TODO: Check up on this to see if still needed. 2026-08-15
  boot.extraModprobeConfig = ''
    # RTL8852CE latency fix
    # Stabilizes firmware calibration and removes ping spikes
    # https://github.com/abdustartus/rtl8852ce-linux-latency-audio-stutter-fix/blob/main/rtw89.conf

    options rtw89_core disable_ps_mode=y
    options rtw89_pci disable_aspm_l1=y
    options rtw89_pci disable_aspm_l1ss=y
    options rtw89_pci disable_clkreq=y
  '';

  nix = {
    buildMachines = [
      {
        hostName = "builder";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        sshUser = "nixremote";
        sshKey = "/root/.ssh/nixremote";
        maxJobs = 3;
        speedFactor = 2;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
        mandatoryFeatures = [];
      }
    ];
    distributedBuilds = true;
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
}
