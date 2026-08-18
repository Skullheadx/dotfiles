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
  services.mpd = {
    enable = true;
    settings = {
      music_directory = "/home/${username}";
      playlist_directory = "/home/${username}/playlists";
      # Old Config
      # music_directory    "~/Music"
      # playlist_directory "~/Music/playlists"
      # db_file            "~/.local/share/mpd/database"
      # state_file         "~/.local/share/mpd/state"
      # log_file           "syslog"
      #
      # auto_update "yes"
      # restore_paused "yes"

      audio_output = [
        {
          type = "pipewire";
          name = "PipeWire Output";
        }
      ];
    };
  };
}
