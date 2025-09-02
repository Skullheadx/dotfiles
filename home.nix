{
  config,
  lib,
  pkgs,
  inputs,
  skullNeovim,
  ...
}: {
  imports = [
    ./sh.nix
    ./ghostty.nix
    ./tmux.nix
    ./hyprland/hyprland.nix
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprsunset.nix
    ./obsidian.nix
    ./fastfetch.nix
    ./udiskie.nix
    ./mpd.nix
    ./rofi.nix
    ./stylix.nix
    ./brave-config.nix
    ./rmpc-theme.nix
    ./rmpc-config.nix
    ./waybar.nix
    ./freetube.nix
    ./qutebrowser.nix
    ./librewolf.nix
    #./schizofox.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello':wq command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    audacity
    mpc
    discord
    catppuccin-gtk
    inter
    prismlauncher
    nixfmt-rfc-style
    p7zip
    github-desktop
    hyprpicker
    wl-clipboard
    wev
    obs-studio
    # hyprsysteminfo  # application to display info about hyprland
    hyprland-qt-support
    hyprutils
    hyprgraphics
    hyprland-qtutils

    helvum
    pavucontrol
    alsa-utils

    grim
    slurp
    swappy

    skullNeovim.neovim

    protonvpn-cli
    protonvpn-gui
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
  home.file = {
    ".config/swappy/config".text = ''
      [Default]
      save_dir=$HOME/Screenshots
      save_filename_format=Screenshot-%Y%m%d-%H%M%S.png
      show_panel=true
      line_size=5
      text_size=20
      text_font=monospace
      paint_mode=brush
      early_exit=true
      fill_shape=false
      auto_save=true
      transparent=true
      transparency=50
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/andrew/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  programs.brave.enable = true;

  programs.rmpc = {
    enable = true;
  };
  #notifcations
  services.dunst.enable = true;
  services.mpd-mpris.enable = true;

  services.playerctld.enable = true;

  programs.git = {
    enable = true;
    userEmail = "admonty1@protonmail.com";
  };

  programs.keepassxc = {
    enable = true;
    #  settings = {
    #    Browser = {
    #    	Enabled = true;
    #	UseCustomBrowser = true;
    #	CustomBrowserType = 1;
    #
    #};
    #    GUI = {
    #      ShowTrayIcon = true;
    #      ApplicationTheme = "dark";
    #    };
    #  };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  services.gnome-keyring = {
    enable = true;
  };

  services.hyprpolkitagent.enable = true;
  home.pointerCursor = {
    hyprcursor.enable = true;
    name = "Bibata-Original-Classic";
    size = 25;
    package = pkgs.bibata-cursors;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
