{
  config,
  pkgs,
  inputs,
  ...
}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    brave
    discord
    utm
    audacity

    zig
    typst
  ];

  environment.systemPath = [
    "/etc/profiles/per-user/andrewmontgomery/bin"
  ];
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  programs.direnv = {
    enable = true;
    enableFzf = true;
    enableMouse = true;
    enableSensible = true;
    enableVim = true;
    extraConfig = ''
      # remap prefix from 'C-b' to 'C-j'
      unbind C-b
      set-option -g prefix C-j
      bind-key C-j send-prefix

      # split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # reload config file
      bind r source-file /etc/tmux.conf \; display-message "Config reloaded"

      # explicitly unbind and rebind s to choose-tree (sessions)
      # (enableVim sets s to split-window, we need to override it)
      unbind s
      bind s choose-tree -s

      # switch panes using Opt + hjkl (Vim-style)
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Enable mouse control (clickable windows, panes, resizable panes)
      set -g mouse on

      # don't rename windows automatically
      set-option -g allow-rename off

      # set the escape time delay to 10
      set -sg escape-time 10


      # DESIGN TWEAKS

      # don't do anything when a 'bell' rings
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      # clock mode
      setw -g clock-mode-colour yellow

      # copy mode
      setw -g mode-style 'fg=black bg=red bold'

      # panes
      set -g pane-border-style 'fg=red'
      set -g pane-active-border-style 'fg=yellow'

      # statusbar
      set -g status-position bottom
      set -g status-justify left
      set -g status-style 'fg=red'

      set -g status-left ""
      set -g status-left-length 10

      set -g status-right-style 'fg=black bg=yellow'
      set -g status-right '%Y-%m-%d %H:%M '
      set -g status-right-length 50

      setw -g window-status-current-style 'fg=black bg=red'
      setw -g window-status-current-format ' #I #W #F '

      setw -g window-status-style 'fg=red bg=black'
      setw -g window-status-format ' #I #[fg=white]#W #[fg=yellow]#F '

      setw -g window-status-bell-style 'fg=yellow bg=red bold'

      # messages
      set -g message-style 'fg=yellow bg=red bold'
    '';
  };

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };

  # services.aerospace = {
  #       enable = true;
  # };

  # services.jankyborders = {
  #       enable = true;
  #       hidpi = true;
  #  active_color="0xffe2e2e3";
  #  inactive_color="0xff414550";
  #  style  = "round";
  # };

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        NSAutomaticCapitalizationEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSWindowShouldDragOnGesture = true;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
      };

      controlcenter.NowPlaying = true;

      dock = {
        autohide = false;
        minimize-to-application = true;
        mru-spaces = false;
        show-recents = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        QuitMenuItem = true;
        ShowMountedServersOnDesktop = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXEnableColumnAutoSizing = true;
        _FXSortFoldersFirst = true;
      };

      screencapture = {
        location = "/Users/andrewmontgomery/Documents/Screenshots";
        type = "jpg";
      };
    };

    keyboard = {
      remapCapsLockToEscape = true;
      swapLeftCtrlAndFn = true;
      enableKeyMapping = true;
    };
  };

  environment.shells = [
    "/run/current-system/sw/bin/fish"
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    user = "andrewmontgomery";

    taps = [
    ];
    brews = [
      "openssh"
      "redis"
    ];
    casks = [
      "keepingyouawake"
      "ghostty"
      "feishu"
      "cursor"
      "surfshark"
      "zen"
      "scroll-reverser"
    ];
  };

  # Primary user for user-specific settings (dock, etc.)
  system.primaryUser = "andrewmontgomery";

  # Dock configuration
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Safari.app"
      "/Applications/Zen.app"
      "/Applications/Feishu.app"
      "/Applications/Ghostty.app"
      "/Applications/Cursor.app"
      "/Applications/Nix Apps/DBeaver.app"
      "/Applications/Surfshark.app"
      "/System/Applications/Utilities/Activity Monitor.app"
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # nixpkgs.config.allowUnsupportedSystem = true;
  power.sleep.display = "never";
}
