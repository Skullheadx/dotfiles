{
  config,
  pkgs,
  inputs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../vim.nix
  ];

  programs.ssh = {
    knownHosts = {
      desktop = {
        extraHostNames = ["192.168.1.122"];
        publicKeyFile = ./../../pubkeys/desktop_ssh.pub;
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
      Host git.skullheadx.com
        HostName 192.168.1.120
        Port 22
        User git
      Host vps
        Hostname 170.205.37.7
        Port 2222
      Host router
        Hostname 192.168.1.115
        Port 2222
    '';
  };

  users.groups.git = {};
  users.groups.nixremote = {};
  users.users.nginx.extraGroups = ["git"];
  systemd.services.nginx.serviceConfig = {
    SupplementaryGroups = ["git"];
    ReadOnlyPaths = [
      "/srv/git"
      "/srv"
    ];
    InaccessiblePaths = [
      "/srv/git/.ssh"
      # "/srv/git/migrate_from_gh.sh"
      # "/srv/git/make_new_repo.sh"
    ];
  };
  # systemd.services.fcgiwrap.serviceConfig.ReadOnlyPaths = ["/srv/git"];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    ${username} = {
      isNormalUser = true;

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
  };

  nix.settings.trusted-users = ["root" "andrew" "nixremote" "@wheel"];

  hjem.users.git = {
    enable = true;
    environment.sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache2";
    };
  };

  services.cgit."cgit" = {
    enable = true;
    scanPath = "/srv/git";
    settings = {
      # readme = "";
      remove-suffix = true;
      root-title = "Skullheadx's Git Forge";
      root-desc = "Source code for various projects";
      repository-sort = "age";
      enable-follow-links = true;
      source-filter = "${pkgs.cgit}/lib/cgit/filters/syntax-highlighting.py";
      strict-export = "git-daemon-export-ok";
      cache-size = 1000;
      cache-root = "/srv/git/.cache";
      clone-url = "git://git.skullheadx.com/$CGIT_REPO_URL";
      enable-http-clone = true;
      enable-index-links = true;
      enable-blame = true;
      enable-commit-graph = true;
      enable-log-filecount = true;
      enable-log-linecount = true;
      enable-subject-links = true;
      # enable-owner-index = false;
      enable-git-config = true;
      local-time = true;
      branch-sort = "age";
      max-stats = "quarter";
      snapshots = "tar.gz tar.bz2 zip";
      logo-link = "https://git.skullheadx.com";
      favicon = "/cgit/favicon.ico";
      logo = "/cgit/logo.webp";
      css = "/cgit/cgit.css";
    };
    extraConfig = ''
      mimetype.gif=image/gif
      mimetype.html=text/html
      mimetype.jpg=image/jpeg
      mimetype.jpeg=image/jpeg
      mimetype.pdf=application/pdf
      mimetype.png=image/png
      mimetype.webp=image/webp
      mimetype.svg=image/svg+xml

      readme=:README.md
      readme=:readme.md
      readme=:README.mkd
      readme=:readme.mkd
      readme=:README.rst
      readme=:readme.rst
      readme=:README.html
      readme=:readme.html
      readme=:README.htm
      readme=:readme.htm
      readme=:README.txt
      readme=:readme.txt
      readme=:README
      readme=:readme
      readme=:INSTALL.md
      readme=:install.md
      readme=:INSTALL.mkd
      readme=:install.mkd
      readme=:INSTALL.rst
      readme=:install.rst
      readme=:INSTALL.html
      readme=:install.html
      readme=:INSTALL.htm
      readme=:install.htm
      readme=:INSTALL.txt
      readme=:install.txt
      readme=:INSTALL
      readme=:install


    '';

    gitHttpBackend = {
      enable = true;
      checkExportOkFiles = true;
    };
    nginx = {
      location = "";
      virtualHost = "git.skullheadx.com";
    };
  };

  services.fcgiwrap.instances."cgit-cgit".process.prefork = 8;

  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    bindAddress = "0.0.0.0";
    secretKeyFile = "/var/cache-priv-key.pem";
  };
  nix.settings.keep-derivations = true;
  nix.settings.keep-outputs = true;

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    experimentalZstdSettings = true;
    recommendedBrotliSettings = true;
    recommendedGzipSettings = true;
    validateConfigFile = true;
    appendHttpConfig = ''
      log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                       '$status $body_bytes_sent "$http_referer" '
                       '"$http_user_agent"';

      access_log /var/log/nginx/access.log main;

      set_real_ip_from 10.0.0.1;
      real_ip_header X-Forwarded-For;

      map $request_uri $limit_key {
        default "";
        ~^/nixpkgs/atom  $binary_remote_addr;
      }

      limit_req_zone $limit_key zone=expensive:10m rate=1r/m;

      map $http_user_agent $bot_class {
          default                        "";
          ~*GPTBot                       "gptbot";
          ~*Amazonbot                    "amazonbot";
          ~*meta-externalagent           "metabot";
      }

      limit_req_zone $bot_class zone=bots:10m rate=1r/m;


    '';
    virtualHosts = {
      "git.skullheadx.com" = {
        listen = [
          {
            addr = "10.0.0.2";
            port = 8080;
          }
          {
            addr = "192.168.1.120";
            port = 8080;
          }
        ];

        extraConfig = ''
          limit_req zone=expensive burst=1 nodelay;
          limit_req zone=bots burst=3 nodelay;
        '';
        locations = {
          "/cgit/" = {
            alias = "/srv/git/cgit/";
          };
          "= /robots.txt" = {
            alias = "/srv/git/cgit/robots.txt";
          };
        };
      };
    };
  };

  services.journald.extraConfig = ''
    SystemMaxUse=500M
    MaxRetentionSec=30day
  '';

  services.gitDaemon = {
    enable = true;
    basePath = "/srv/git";
    listenAddress = "0.0.0.0";
    exportAll = false;
  };

  programs.git.config.url."git://127.0.0.1/" = {
    insteadOf = [
      "git://git.skullheadx.com/"
    ];
  };

  # IRC
  services.soju = {
    adminSocket.enable = true;
    enable = true;
    listen = [
      "irc+insecure://10.0.0.2:6667"
      "irc+insecure://192.168.1.120:6667"
    ];
    hostName = "skullheadx.com";
  };

  # NFS
  services.nfs = {
    server = {
      enable = true;
      createMountPoints = true;
      exports = ''
        /srv/data *(rw,sync,no_subtree_check,crossmnt,fsid=0,root_squash)
      '';
      extraNfsdConfig = ''
        [nfsd]
        vers3=off
        vers4=yes
        udp=off
        tcp=on
      '';
    };
  };
  fileSystems."/srv/data" = {
    device = "/dev/disk/by-uuid/9014f510-b08e-488f-8c43-20a4ac7f15cc";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };
  networking.hostName = "icon";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wireguard-tools
    nfs-utils
    btop
    nethogs
    screen
  ];

  programs.git = {
    enable = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged
    # programs here, NOT in environment.systemPackages
  ];

  environment.sessionVariables = {
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services
  services.openssh.enable = true;
  services.rsync = {
    enable = true;
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
        "/git.skullheadx.com/192.168.1.115"
        "/nix-cache.skullheadx.com/192.168.1.115"
        "/irc.skullheadx.com/192.168.1.115"
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

  # TODO: Remove this when you setup your own router
  networking.networkmanager.dns = "none";
  networking.nameservers = ["127.0.0.1"];
  networking.useDHCP = false;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    9418
    22
    8080
    6667
    6697
    2049
    5000
    53
  ]; # git, git (ssh), cgit, irc (vps), irc (local), nfs, nix-serve-ng, dns
  networking.firewall.allowedUDPPorts = [
    55555
    53
  ]; # wireguard, dns
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.wireguard = {
    enable = true;
  };

  networking.wg-quick.interfaces.wg0 = {
    address = ["10.0.0.2/24"];
    privateKeyFile = "/var/lib/wireguard/private.key";
    mtu = 1360;

    peers = [
      {
        publicKey = "q0CnToO9bQ0sAMQER9CCCbry/UDC1Yf2VWSz/WiMBEM=";
        allowedIPs = ["10.0.0.1/32"];
        endpoint = "170.205.37.7:55555";
        persistentKeepalive = 25;
      }
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
