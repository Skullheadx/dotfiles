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
    ./../../hjem.nix
    ./../../audio.nix
    ./../../vim.nix
    ./../../sh.nix
  ];

  networking.hostName = "nepsis";
  networking.extraHosts = ''
    0.0.0.0 youtube.com
    0.0.0.0 www.youtube.com
    0.0.0.0 www.youtu.be
  '';

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  programs.ssh = {
    knownHosts = {
      homelab = {
        extraHostNames = ["192.168.1.120"];
        publicKeyFile = ./../../pubkeys/homelab_ssh.pub;
      };
      laptop = {
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
    fastfetch
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
  ];

  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = [pkgs.passff-host];
    package = pkgs.librewolf;
  };

  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Skullheadx";
        email = "admonty1@protonmail.com";
      };
      pull.rebase = true;
      url = {
        "git@github.com:".insteadOf = "https://github.com/";
      };
    };
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
