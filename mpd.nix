{ config, pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/.playlists";
    extraConfig = ''
      		      auto_update "yes"
		      audio_output {
			type "pulse"
			name "PipeWire Output"
		      }
      	      	'';
  };
}
