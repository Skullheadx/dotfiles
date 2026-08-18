{
  config,
  pkgs,
  username,
  ...
}: {
  # TODO: Why is pipewire AND wireplumber enabled?
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  services.pipewire.wireplumber.enable = true;

  # TODO: WTF is this?
  hardware = {
    graphics = {
      enable = true;
    };
  };

  # TODO: Why am I using this instead of services.mpd.enable = true
  systemd.user.services.mpd = {
    description = "Music Player Daemon";
    wantedBy = ["default.target"];
    serviceConfig = {
      ExecStart = "${pkgs.mpd}/bin/mpd --no-daemon /home/${username}/.config/mpd/mpd.conf";
      Restart = "on-failure";
    };
  };
}
