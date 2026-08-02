{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../lockscreen.nix
    ./../../x11.nix
    ./../../hjem-linux.nix
    ./../../audio.nix
    ./../../vim.nix
  ];

  networking.hostName = "nepsis";
  # networking.extraHosts = ''
  #   0.0.0.0 youtube.com
  #   0.0.0.0 www.youtube.com
  #   0.0.0.0 www.youtu.be
  # '';

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # TODO: Remove this when you setup your own router
  networking.networkmanager.dns = "none";
  networking.nameservers = ["192.168.1.120"];
  networking.useDHCP = false;

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
      Host git.skullheadx.com
        HostName 192.168.1.120
        Port 22
        User git
      Host homelab
        HostName 192.168.1.120
        Port 22
      Host vps
        Hostname 170.205.37.7
        Port 2222
      Host builder
        HostName 192.168.1.120
        StrictHostKeyChecking=accept-new
        IdentitiesOnly yes
        IdentityFile /root/.ssh/nixremote
        User nixremote
    '';
  };

  nix.buildMachines = [
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
  nix.distributedBuilds = true;
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    nixfmt
    st
    dmenu
    feh
    sxhkd
    pamixer
    maim
    slop
    xclip
    xdotool
    gcc
    slstatus
    scrolling-title
    surf
    surf_search
    terminus_font
    terminus_font_ttf
    yt-dlp
    wireguard-tools
    nethogs
    iftop
    nfs-utils
    pass
    passExtensions.pass-otp
    passExtensions.pass-update
    passExtensions.pass-import
    bibata-cursors
    libreoffice-fresh
    obs-studio
    sent
    zig
    typst
    bat
    (python314.withPackages (ps:
      with ps; [
        opencv4
      ]))
  ];

  services.emacs = {
    enable = true;
    startWithGraphical = config.services.xserver.enable;
    install = true;
    # defaultEditor = true;
  };

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

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages
  ];

  environment.sessionVariables = {
    BROWSER = "surf";
    SFEED_PLUMBER = "$BROWSER";
    SFEED_URL_FILE = "$HOME/.local/share/sfeed/sfeed_read_url_file";
    XCURSOR_SIZE = 25;
    XCURSOR_THEME = "Bibata-Modern-Ice";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg = {
    dirmngr.enable = true;
    agent = {
      enable = true;
      enableSSHSupport = true;
      enableBrowserSocket = true;
      settings = {
        default-cache-ttl = 86400;
        max-cache-ttl = 604800;
      };
    };
  };

  # Services
  services.openssh = {
    enable = true;
  };
  services.rsync = {
    enable = true;
  };

  fileSystems."/mnt/data" = {
    device = "192.168.1.120:/";
    fsType = "nfs4";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "rw"
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
