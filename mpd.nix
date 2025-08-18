{ config, pkgs, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/.playlists";
    extraConfig = ''
      		      auto_update "yes"
      		      restore_paused "yes"
      	      	'';
  };
}
