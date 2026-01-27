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
    neovim
    babelfish
    brave
    # firefox
    discord
    zig
    zls
    utm
    sqlite
    dbeaver-bin
    uv
    lazygit
    ngrok
    audacity
    # language server
    bash-language-server
    clang-tools
    docker-language-server
    gopls
    golangci-lint-langserver
    vscode-langservers-extracted
    emmet-language-server
    lua-language-server
    marksman
    nixd
    basedpyright
    ruff
    sqls
    deno
    vtsls
    yaml-language-server
    zls

    # formatter
    shfmt
    gofumpt
    prettierd
    prettier
    jq
    stylua
    nixpkgs-fmt
    sqlfluff

    # linter
    shellcheck
    cppcheck
    hadolint
    fish
    golangci-lint
    selene
    markdownlint-cli2
    statix
    eslint
    yamllint

    # debugger
    lldb
    delve
    python313Packages.debugpy

    # tree sitter
    tree-sitter
  ];

  environment.systemPath = [
    "/etc/profiles/per-user/andrewmontgomery/bin"
  ];
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.

  programs.fish.enable = true;
  programs.tmux = {
    enable = true;
    enableFzf = true;
    enableMouse = true;
    enableSensible = true;
    enableVim = true;
    extraConfig = "
        # remap prefix from 'C-b' to 'C-j'
        unbind C-b
        set-option -g prefix C-j
        bind-key C-j send-prefix

        # split panes using | and -
        bind | split-window -h
        bind - split-window -v
        unbind '\"'
        unbind %

        unbind s
        bind s choose-tree -s

        # reload config file (change file location to your the tmux.conf you want to use)
        bind r source-file /etc/tmux.conf


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

        set -g status-left ''
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


        # nvf
        set-option -g focus-events on

      ";
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
  system.defaults.NSGlobalDomain.AppleICUForce24HourTime = true;
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
  system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;

  system.defaults.controlcenter.NowPlaying = true;

  system.defaults.dock = {
    autohide = false;
    minimize-to-application = true;
    mru-spaces = false;
    show-recents = false;
    persistent-apps = [
      "/System/Applications/Reminders.app"
      "/System/Applications/Calendar.app"
      "/System/Applications/Music.app"
      "/System/Applications/Messages.app"

      "/Applications/KeePassXC.app"
      "/Applications/Ghostty.app"
      # "/Applications/Nix Apps/Brave Browser.app"
      "/Applications/LibreWolf.app"
      "/Applications/Nix Apps/UTM.app"

      "/System/Applications/System Settings.app"
    ];
  };
  system.defaults.finder = {
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

  system.defaults.screencapture.location = "/Users/andrewmontgomery/Documents/Screenshots";
  system.defaults.screencapture.type = "jpg";
  system.keyboard.remapCapsLockToEscape = true;
  system.keyboard.swapLeftCtrlAndFn = true;
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
    ];
    casks = [
      "selfcontrol"
      "keepingyouawake"
      "freetube"
      "protonvpn"
      "keepassxc"
      "ghostty"
      "steam"
      "discord"
      "corretto@11" # java runtime for matlab
      "scroll-reverser"
      "librewolf"
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
  system.primaryUser = "andrewmontgomery";

  programs.direnv = {
    enable = true;
    # enableFishIntegration = true;
  };
  system.keyboard.enableKeyMapping = true;
}
