{
  config,
  pkgs,
  username,
  ...
}: {
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

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  hjem.users.${username} = {
    files = {
      ".config/mpd/mpd.conf".source = ./dotfiles/mpd/mpd.conf;

      ".config/rmpc/config.ron".source = ./dotfiles/rmpc/config.ron;
      ".config/rmpc/themes/theme.ron".source = ./dotfiles/rmpc/themes/theme.ron;
    };
    packages = with pkgs; [
      mpc
      rmpc
    ];
  };

  systemd.user.services.mpd = {
    description = "Music Player Daemon";
    wantedBy = ["default.target"];
    serviceConfig = {
      ExecStart = "${pkgs.mpd}/bin/mpd --no-daemon /home/${username}/.config/mpd/mpd.conf";
      Restart = "on-failure";
    };
  };
}
