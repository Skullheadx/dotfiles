{ config, pkgs, inputs, ... }: {
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
    # enableVim = true;
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
  system.defaults.dock.autohide = false;

  system.defaults.dock.minimize-to-application = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.show-recents = false;
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
    user = "andrewmontgomery";

    taps = [
    ];
    brews = [
      "openssh"
    ];
    casks = [
      "freetube"
      "protonvpn"
      "keepassxc"
      "ghostty"
      "steam"
      "discord"
      "corretto@11" # java runtime for matlab
      # "feishu"
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
 
