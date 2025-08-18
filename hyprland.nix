{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "DP-3,2560x1440@180.00,0x0,1"
        "DP-2,1920x1080@165.00,2560x360,1"
      ];
      "$mod" = "SUPER";
      input = {
        kb_layout = "us";
        kb_options = "caps:escape";
        numlock_by_default = true;

      };
      workspace = [
        "1, monitor:DP-3"
        "2, monitor:DP-3"
        "3, monitor:DP-3"
        "4, monitor:DP-3"
        "5, monitor:DP-3"
        "6, monitor:DP-2"
        "7, monitor:DP-2"
        "8, monitor:DP-2"
        "9, monitor:DP-2"
        "0, monitor:DP-2"
      ];
      exec-once = [
        "xrandr --output DP-3 --primary"
        "[workspace 1 silent] ghostty"
        "[workspace 2 silent] ghostty -e rmpc"
        "[workspace 3 silent] obsidian"
        "[workspace 6 silent] brave"
        "[workspace 7 silent] discord"
        "[workspace 8 silent] steam"
      ];
      windowrule = [
        "workspace 7 silent, class:(discord)"
        "workspace 8 silent, class:(steam)"
      ];

      bind = [
        "$mod, f, exec, ghostty"
        "$mod, d, exec, brave"
        "$mod, space, exec, rofi -show drun"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && notify-send 'Volume Up'"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify-send 'Volume Down'"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send 'Mute Toggled'"
	", XF86AudioNext, exec, playerctl next && notify-send 'Next Song'"
	", XF86AudioPrev, exec, playerctl previous && notify-send 'Previous Song'"
	", XF86AudioPlay, exec, playerctl play-pause && notify-send 'Pause/Play Toggled'"
	", XF86AudioStop, exec, playerctl stop && notify-send 'Music Stopped'"
        ", F10, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && notify-send 'Volume Up'"
        ", F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify-send 'Volume Down'"
        ", F9, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send 'Mute Toggled'"
	", F6, exec, playerctl next && notify-send 'Next Song'"
	", F5, exec, playerctl previous && notify-send 'Previous Song'"
	", F7, exec, playerctl play-pause && notify-send 'Pause/Play Toggled'"
	", F8, exec, playerctl stop && notify-send 'Music Stopped'"
      ]
      ++ (
        # workspaces
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoWorkspace, ${toString ws}"
            ]
          ) 9
        )
      );
    };
  };

}
