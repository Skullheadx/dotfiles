{
  config,
  pkgs,
  inputs,
  customNeovim,
  ...
}: {
  networking = {
    computerName = "bear";
    hostName = "bear";
    localHostName = "bear";
  };
  # Primary user for user-specific settings (dock, etc.)
  system.primaryUser = "andrewmontgomery";
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    customNeovim.neovim
    senpai
    mpv
  ];

  programs.ssh = {
    knownHosts = {
      homelab = {
        extraHostNames = ["192.168.1.120"];
        publicKeyFile = ./../../pubkeys/homelab_ssh.pub;
      };
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

  homebrew = {
    enable = true;
    user = "andrewmontgomery";

    taps = [
    ];
    brews = [
    ];
    casks = [
      "keepassxc"
      "protonvpn"
      "selfcontrol"
      "kdenlive"
      "audacity"
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

      "/Applications/KeePassXC.app"
      "/Applications/Ghostty.app"
      # "/Applications/Nix Apps/Brave Browser.app"
      "/Applications/Nix Apps/LibreWolf.app"
      # "/Applications/Nix Apps/UTM.app"

      "/System/Applications/System Settings.app"
    ];
  };
}
