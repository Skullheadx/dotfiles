{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [];
  };

  hjem.users.${username} = {
    directory = "/home/${username}";
    files = {
      ".config/surf/styles/default.css".source = ./dotfiles/surf/styles/default.css;
      ".config/surf/script.js".source = ./dotfiles/surf/script.js;

      ".sfeed/sfeedrc".source = ./dotfiles/sfeed/sfeedrc;

      ".config/fastfetch/config.jsonc".source = ./dotfiles/fastfetch/config.jsonc;
      ".config/lazygit/config.yml".source = ./dotfiles/lazygit/config.yml;
      ".config/tealdeer/config.toml".source = ./dotfiles/tealdeer/config.toml;
    };

    packages = with pkgs; [
      discord
      lazygit
      librewolf
      btop
      mpv
      zathura
      lf
      sfeed
      delta
    ];
  };

  systemd.user.services."sfeed-update" = {
    description = "Update sfeed RSS feeds";
    path = with pkgs; [
      curl
      sfeed
      coreutils
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.sfeed}/bin/sfeed_update";
    };
  };

  systemd.user.timers."sfeed-update" = {
    description = "Run sfeed_update daily";
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
    wantedBy = ["timers.target"];
  };
}
