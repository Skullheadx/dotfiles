{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andrew = {
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  hjem.users.andrew = {
    directory = "/home/andrew";
    files = {

      ".config/sxhkd/sxhkdrc".text = ''
        super + space
        	${pkgs.dmenu}/bin/dmenu_run

        super + Return
        	${pkgs.st}/bin/st	

        super + b
        	${pkgs.librewolf}/bin/librewolf

        XF86AudioRaiseVolume
            ${pkgs.pamixer}/bin/pamixer -i 5

        XF86AudioLowerVolume
            ${pkgs.pamixer}/bin/pamixer -d 5

        XF86AudioMute
            ${pkgs.pamixer}/bin/pamixer -t

        super + s
            ${pkgs.maim}/bin/maim -i $(${pkgs.xdotool}/bin/xdotool getactivewindow) | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png

        super + shift + s
            ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png
      '';
    };
    packages = with pkgs; [
      discord
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  (lib.lowPrio pkgs.vim) # Lower Vim's priority
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
    librewolf
    nixfmt
    st
    dmenu
    feh
    fastfetch
    sxhkd
    betterlockscreen
    pamixer
    maim
    slop
    xclip
    xdotool
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

  programs.i3lock = {
    enable = true;
    package = pkgs.i3lock-color;
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

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
  services.pipewire.wireplumber.enable = true;
  hardware = {
    graphics = {
      enable = true;
    };
  };

#  services.mpd = {
#    enable = true;
#    musicDirectory = "${config.home.homeDirectory}/Music";
#    playlistDirectory = "${config.home.homeDirectory}/.playlists";
#    # mixer_type "none" # maybe mess around with this some time, it will turn off volume in rmpc, but apparently it will make the sound more quality for music
#     extraConfig = ''
#       		      auto_update "yes"
# 		      audio_output {
# 			type "pulse"
# 			name "PipeWire Output"
# 		      }
#       	      	'';
#  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services
  services.openssh.enable = true;

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "gameoflife";
      clock = "%c";
      vi_mode = true;
      vi_default_mode = "insert";
      numlock = true;
      bigclock = "en";
      bigclock_seconds = true;
    };

  };
  services.dunst = {
    enable = true;
  };
  security.pam.services.betterlockscreen = { };

  services.xserver = {
    enable = true;
    autorun = true;
    enableTearFree = true;
    windowManager.dwm.enable = true;
    desktopManager.runXdgAutostartIfNone = false;
    displayManager = {
      setupCommands = '''';
      sessionCommands = ''
        		#!/bin/sh
        		${pkgs.xrandr}/bin/xrandr --output DP-3 --primary --mode 2560x1440 --rate 180 --pos 0x0 --output DP-2 --mode 1920x1080 --rate 160 --pos 2560x360
        		${pkgs.feh}/bin/feh --no-fehbg --bg-fill '/home/andrew/Wallpapers/Daniel_in_the_Lions_Den_by_Briton_Riviere.jpg'
        		${pkgs.sxhkd}/bin/sxhkd &
      '';
    };
    xkb = {
      layout = "us";
      options = "caps:escape";
    };
    xautolock = {
      enable = true;
      enableNotifier = true;
      notifier = "${pkgs.dunst}/bin/notify-send 'Locking in 10 seconds'";
      locker = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dimblur";
    };
    config = ''
      Section "InputClass"
        Identifier "Kinesis Advantage 360"
        MatchIsKeyboard "on"
        MatchVendor "Kinesis"
        Option "XkbModel" "kinesis"
        Option "XkbLayout" "us"
      EndSection
    '';
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
