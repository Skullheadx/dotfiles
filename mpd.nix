{ config, pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/.playlists";
    # mixer_type "none" # maybe mess around with this some time, it will turn off volume in rmpc, but apparently it will make the sound more quality for music
    extraConfig = ''
      		      auto_update "yes"
		      audio_output {
			type "pulse"
			name "PipeWire Output"
		      }
      	      	'';
  };
}
