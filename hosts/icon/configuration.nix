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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPfIZMlXeTEi0YoOq36WNo6xPoolqvoS77ygtKaySkoG admonty1@protonmail.com"
      ];
    };
  };

  services.gitweb = {
    projectroot = "/srv/git";
    extraConfig = ''$site_name =  "Skullheadx\'s Git Forge"'';
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "git.skullheadx.com" = {
        listen = [
          {
            addr = "10.0.0.2";
            port = 8080;
          }
        ];
      };
    };
    gitweb = {
      enable = true;
      location = "";
      virtualHost = "git.skullheadx.com";
    };
  };

  services.gitDaemon = {
    enable = true;
    basePath = "/srv/git";
    listenAddress = "10.0.0.2";
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
  networking.firewall.allowedTCPPorts = [9418 8080];
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
