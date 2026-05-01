{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./lockscreen.nix
    ./x11.nix
    ./hjem.nix
    ./audio.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nepsis";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (lib.lowPrio pkgs.vim-full) # Lower Vim's priority
    (pkgs.writeShellApplication {
      name = "vi";
      runtimeInputs = [ pkgs.nvi ];
      text = ''
        exec ${pkgs.nvi}/bin/vi "$@"
      '';
    })

    neovim
    wget
    git
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
    terminus_font
    terminus_font_ttf

  ];

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

  programs.bash = {
    enable = true;
    interactiveShellInit = ''
      shopt -s autocd
      shopt -s cdable_vars
      shopt -s cdspell
      shopt -s dirspell
      shopt -s checkjobs
      shopt -s cmdhist
      shopt -s histappend
      shopt -s globstar
      shopt -s extglob
    '';
    promptInit = ''
      PS1="\[\e[97m\][\[\e[m\]\[\e[92m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[92m\]\h\[\e[m\]:\[\e[92m\]\w\[\e[m\]\[\e[97m\]]\[\e[m\]\[\e[97m\]\\$\[\e[m\] "
    '';
  };

  environment.etc."inputrc".text = ''
    set editing-mode vi
    set show-mode-in-prompt on
    set keyseq-timeout 10

    set vi-ins-mode-string "\1\e[5 q\2"
    set vi-cmd-mode-string "\1\e[2 q\2"


    set colored-stats on
    set colored-completion-prefix on
    set blink-matching-paren on

    set completion-ignore-case on
    set show-all-if-ambiguous on
    set completion-map-case on
  '';


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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services
  services.openssh.enable = true;

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
