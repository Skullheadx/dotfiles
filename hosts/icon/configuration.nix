{
  config,
  pkgs,
  inputs,
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
      vps = {
        extraHostNames = ["170.205.37.7"];
        publicKeyFile = ./../../pubkeys/vps_ssh.pub;
      };
      github = {
        extraHostNames = ["github.com"];
        publicKeyFile = ./../../pubkeys/github_ssh.pub;
      };
    };
  };

  users.groups.git = {};
  users.users.nginx.extraGroups = ["git"];
  systemd.services.nginx.serviceConfig = {
    SupplementaryGroups = ["git"];
    ReadOnlyPaths = ["/srv/git" "/srv"];
  };
  # systemd.services.fcgiwrap.serviceConfig.ReadOnlyPaths = ["/srv/git"];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    andrew = {
      isNormalUser = true;

      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [lazygit];
    };
    git = {
      isSystemUser = true;
      shell = "${pkgs.git}/bin/git-shell";
      group = "git";
      home = "/srv/git";
      createHome = true;
      homeMode = "755";
      openssh.authorizedKeys.keyFiles = [../../pubkeys/desktop_ssh.pub];
    };
  };

  services.gitweb = {
    projectroot = "/srv/git";
    extraConfig = ''
      $site_name =  "Skullheadx\'s Git Forge";
      $omit_owner = 1;
    '';
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "gitweb.skullheadx.com" = {
        listen = [
          {
            addr = "10.0.0.2";
            port = 8080;
          }
        ];
      };
      "git.skullheadx.com" = {
        listen = [
          {
            addr = "10.0.0.2";
            port = 8081;
          }
        ];
      };
    };
    gitweb = {
      enable = true;
      location = "";
      virtualHost = "gitweb.skullheadx.com";
    };
  };

  services.gitDaemon = {
    enable = true;
    basePath = "/srv/git";
    listenAddress = "10.0.0.2";
  };

  services.autossh.sessions = [
    {
      name = "git-vps-tunnel";
      user = "git";
      monitoringPort = 20000;
      extraArguments = "-F /dev/null -o SendEnv=none -M 20000 -N -R 2223:localhost:22 git@git.skullheadx.com -p 2222";
    }
  ];

  services.lighttpd = {
    enable = false;
    port = 8081;
    enableModules = ["mod_cgi" "mod_alias" "mod_setenv"];
    extraConfig = ''
      # 1. Explicitly block any push attempts (git-receive-pack) with a 403 Forbidden
      $HTTP["querystring"] =~ "service=git-receive-pack" {
          url.access-deny = ("")
      }
      $HTTP["url"] =~ "^/.*/git-receive-pack$" {
          url.access-deny = ("")
      }

      # 2. Redirect the root URL "/" to the git-http-backend
      alias.url += ( "/" => "${pkgs.git}/git-http-backend" )

      # 3. Apply Git variables globally to the root path
      $HTTP["url"] =~ "^/" {
          cgi.assign = ("" => "")
          setenv.add-environment = (
              "GIT_PROJECT_ROOT" => "/srv/git",
              "GIT_PROTOCOL" => "HTTP_GIT_PROTOCOL"
          )
      }
    '';
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
    btop
    nethogs
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

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [9418 8080 8081];
  networking.firewall.allowedUDPPorts = [55555];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.wireguard = {
    enable = true;
  };

  networking.wg-quick.interfaces.wg0 = {
    address = ["10.0.0.2/24"];
    privateKeyFile = "/var/lib/wireguard/private.key";

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
