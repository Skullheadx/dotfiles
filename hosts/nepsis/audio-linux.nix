{
  config,
  pkgs,
  username,
  ...
}: {
  # Whether to enable the RealtimeKit system service, which hands out realtime scheduling priority to user processes on demand. For example, PulseAudio and PipeWire use this to acquire realtime priority.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };
  services.pulseaudio.enable = false;

  # TODO: WTF is this?
  hardware = {
    graphics = {
      enable = true;
    };
  };

  services.mpd = {
    enable = true;
    user = username;
    settings = {
      music_directory = "/home/${username}/Music";
      playlist_directory = "/home/${username}/Music/playlists";
      # Old Config
      # music_directory    "~/Music"
      # playlist_directory "~/Music/playlists"
      # db_file            "~/.local/share/mpd/database"
      # state_file         "~/.local/share/mpd/state"
      # log_file           "syslog"
      # auto_update = true;
      # restore_paused = true;

      audio_output = [
        {
          type = "pipewire";
          name = "PipeWire Output";
        }
      ];
    };
  };
  systemd.services.mpd = {
    environment.XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.andrew.uid}";
    serviceConfig.Restart = "on-failure";
    serviceConfig.RestartSec = 2;
  };
}
