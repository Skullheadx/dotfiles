{ config, pkgs, ... }:

{
	
imports = [ 
	./binds.nix
];
  wayland.windowManager.hyprland = {
      "$mod" = "SUPER";

      bind = [
        "$mod, f, exec, ghostty"
        "$mod, d, exec, brave"
        "$mod, space, exec, pkill rofi || rofi -show drun"
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
