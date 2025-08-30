{ config, pkgs, ... }:

{

  imports = [
    ./binds.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
env = [
  "EDITOR,nvim"
  "VISUAL,nvim"
  "HYPRCURSOR_THEME,Bibata-Original-Classic"
  "HYPRCURSOR_SIZE,24"
];
      monitor = [
        "DP-3,2560x1440@180.00,0x0,1"
        "DP-2,1920x1080@165.00,2560x360,1"
      ];
      input = {
        kb_layout = "us";
        kb_options = "caps:escape,altwin:swap_lalt_lwin";

        numlock_by_default = true;

      };

      workspace = [
        "1, monitor:DP-3" # term
        "2, monitor:DP-2" # browser
        "3, monitor:DP-3" # music 
        "4, monitor:DP-2" # discord
        "5, monitor:DP-3" # games
        "6, monitor:DP-2" # password manager
        "7, monitor:DP-2"
        "8, monitor:DP-2" # steam 
        "9, monitor:DP-3" # notes
        "10, monitor:DP-2"
	"w[tv1], gapsout:0, gapsin:0"
	"f[1], gapsout:0, gapsin:0"
      ];
      exec-once = [
        "xrandr --output DP-3 --primary"
	"uwsm app -- waybar"
        "[workspace 1 silent] uwsm app -- ghostty"
        "[workspace 2 silent] uwsm app -- brave"
	"[workspace 3 silent] uwsm app -- ghostty -e fish -c rmpc"
        "[workspace 4 silent] uwsm app -- discord"
        "[workspace 6 silent] uwsm app -- keepassxc"
        "[workspace 8 silent] uwsm app -- steam"
        "[workspace 9 silent] uwsm app -- obsidian"
      ];
      windowrule = [
        "workspace 4 silent, class:(discord)"
        "workspace 8 silent, class:(steam)"
        "workspace 8 silent, class:(steam)"



	"bordersize 0, floating:0, onworkspace:w[tv1]"
	"rounding 0, floating:0, onworkspace:w[tv1]"
	"bordersize 0, floating:0, onworkspace:f[1]"
	"rounding 0, floating:0, onworkspace:f[1]"
      ];


    };
  };

}
