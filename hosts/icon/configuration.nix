{
  config,
  pkgs,
  inputs,
  username,
  ips,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./web.nix
    ./irc-bouncer.nix
    ./nfs.nix
  ];

  users = {
    groups = {
      git = {};
      nixremote = {};
    };
    users = {
      ${username} = {
        isNormalUser = true;
        shell = pkgs.zsh;

        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        packages = with pkgs; [lazygit];
        openssh.authorizedKeys.keyFiles = [
          ../../pubkeys/desktop_ssh.pub
          ../../pubkeys/laptop_ssh.pub
          ../../pubkeys/work_laptop_ssh.pub
        ];
      };

      git = {
        isSystemUser = true;
        shell = "${pkgs.git}/bin/git-shell";
        group = "git";
        home = "/srv/git";
        createHome = true;
        homeMode = "755";
        openssh.authorizedKeys.keyFiles = [
          ../../pubkeys/eric_ssh.pub
          ../../pubkeys/desktop_ssh.pub
          ../../pubkeys/homelab_ssh.pub
          ../../pubkeys/homelab2_ssh.pub
          ../../pubkeys/laptop_ssh.pub
          ../../pubkeys/work_laptop_ssh.pub
          ../../pubkeys/gamer_desktop_ssh.pub
          ../../pubkeys/gamer_laptop_ssh.pub
        ];
      };

      nixremote = {
        isSystemUser = true;
        group = "nixremote";
        home = "/home/nixremote";
        shell = pkgs.bash;
        createHome = true;
        homeMode = "555";
        openssh.authorizedKeys.keyFiles = [
          ../../pubkeys/desktop_builder_ssh.pub
        ];
      };

      nginx.extraGroups = ["git"];
    };
  };

  nix.settings.trusted-users = ["root" "andrew" "nixremote" "@wheel"];

  hjem.users.git = {
    enable = true;
    environment.sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache2";
    };
  };

  services.journald.extraConfig = ''
    SystemMaxUse=500M
    MaxRetentionSec=30day
  '';

  environment = {
    systemPackages = with pkgs; [
      nfs-utils
      btop
      screen
    ];
    sessionVariables = {};
  };

  # Services
  services.rsync = {
    enable = true;
  };

  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    bindAddress = "0.0.0.0";
    secretKeyFile = "/var/cache-priv-key.pem";
  };

  # Do not delete my builds
  nix.settings = {
    keep-derivations = true;
    keep-outputs = true;
  };

  networking = {
    hostName = "icon";

    firewall = {
      allowedTCPPorts = [
        9418
        22
        8080
        6667
        2049
        5000
        53
      ]; # git, git (ssh), cgit, irc (insecure), nfs, nix-serve-ng, dns
      allowedUDPPorts = [
        55555
        53
      ]; # wireguard, dns
    };

    # Must turn off dns auto assignment so that we use our dnsmasq resolver
    networkmanager.dns = "none";
    nameservers = ["127.0.0.1"];
    useDHCP = false;

    defaultGateway = {
      # TODO: Figure out what's at this IP
      address = "192.168.1.1";
      interface = "eno1";
    };

    interfaces.eno1 = {
      ipv4 = {
        addresses = [
          {
            address = "${ips.ip_local_homelab}";
            prefixLength = 24;
          }
        ];
        routes = [
          {
            address = "${ips.ip_wg_router}";
            prefixLength = 32;
            via = "${ips.ip_local_router}";
          }
        ];
      };
    };

    wireguard = {
      enable = true;
    };
    wg-quick.interfaces.wg0 = {
      address = ["${ips.ip_wg_homelab}/24"];
      privateKeyFile = "/var/lib/wireguard/private.key";
      # max transmission unit so that packets don't get split
      mtu = 1360;

      # We use 55555 instead of default since that is blocked I think
      listenPort = 55555;

      peers = [
        {
          publicKey = "q0CnToO9bQ0sAMQER9CCCbry/UDC1Yf2VWSz/WiMBEM=";
          allowedIPs = ["${ips.ip_wg_vps}/32"];
          endpoint = "${ips.ip_pub_vps}:55555";
          # we are behind NAT, so we must keep the connection alive in case the public IP of homelab changes
          persistentKeepalive = 25;
        }
      ];
    };
  };

  services.dnsmasq = {
    enable = true;
    alwaysKeepRunning = true;
    resolveLocalQueries = true;
    settings = {
      interface = ["eno1" "lo"];
      bind-interfaces = true;

      # num of dns entries to cache
      cache-size = 10000;
      domain-needed = true;
      bogus-priv = true;
      no-hosts = true;
      no-resolv = true;

      port = 53;
      address = [
        "/git.skullheadx.com/${ips.ip_local_router}"
        "/nix-cache.skullheadx.com/${ips.ip_local_router}"
        "/irc.skullheadx.com/${ips.ip_local_router}"
      ];

      # Upstream dns
      server = [
        "192.168.1.211"
        "1.1.1.1"
        "9.9.9.9"
      ];

      # pihole
      # split horizon config
    };
  };

  programs.ssh = {
    knownHosts = {
      desktop = {
        extraHostNames = [ips.ip_local_desktop];
        publicKeyFile = ./../../pubkeys/desktop_ssh.pub;
      };
      laptop = {
        publicKeyFile = ./../../pubkeys/laptop_ssh.pub;
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
      Host git.skullheadx.com
        HostName ${ips.ip_local_homelab}
        Port 22
        User git
      Host vps
        Hostname ${ips.ip_pub_vps}
        Port 2222
      Host router
        Hostname ${ips.ip_local_router}
        Port 2222
    '';
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
    ports = [22 2222];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
