{
  lib,
  config,
  pkgs,
  ...
}: let
  # workspaces
  workspaces = builtins.concatLists (
    builtins.genList (
      i: let
        ws = i + 1;
      in [
        "$mod, code:1${toString i}, workspace, ${toString ws}"
        "$mod SHIFT, code:1${toString i}, movetoWorkspace, ${toString ws}"
      ]
    )
    10
  );
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bind =
      [
        # compositor commands
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, W, killactive,"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        #"$mod, G, togglegroup,"
        #       "$mod SHIFT, N, changegroupactive, f"
        # "$mod SHIFT, P, changegroupactive, b"
        #"$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        #"$mod, P, pseudo,"
        #"$mod ALT, ,resizeactive,"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        "$mod CTRL, left, resizeactive, -10 0"
        "$mod CTRL, down, resizeactive, 0 10"
        "$mod CTRL, up, resizeactive, 0 -10"
        "$mod CTRL, right, resizeactive, 10 0"
        "$mod CTRL, h, resizeactive, -10 0"
        "$mod CTRL, j, resizeactive, 0 10"
        "$mod CTRL, k, resizeactive, 0 -10"
        "$mod CTRL, l, resizeactive, 10 0"

        "$mod, D, exec, uwsm app -- ghostty"
        "$mod, b, exec, librewolf"
        "$mod, space, exec, pkill rofi || rofi -show drun"
        "$mod, p, exec, pkill hyprpicker || hyprpicker -ar"
        "$mod SHIFT, s, exec, pkill slurp || grim -g \"$(slurp)\" - | wl-copy"
        ", PRINT, exec, grim - | wl-copy"
        "SHIFT, PRINT, exec, pkill slurp swappy || grim -g \"$(slurp)\" - | swappy -f -"
        ", XF86Explorer, exec, hyprlock"
        ", F1, exec, hyprlock"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && notify-send 'Volume Up'"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify-send 'Volume Down'"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send 'Mute Toggled'"
        ", XF86AudioNext, exec, playerctl next && notify-send 'Next Song'"
        ", XF86AudioPrev, exec, playerctl previous && notify-send 'Previous Song'"
        ", XF86AudioPlay, exec, playerctl play-pause && notify-send 'Pause/Play Toggled'"
        ", XF86AudioStop, exec, playerctl stop && notify-send 'Music Stopped'"
        ", F11, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && notify-send 'Volume Up'"
        ", F10, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify-send 'Volume Down'"
        ", F9, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send 'Mute Toggled'"
        ", F6, exec, playerctl next && notify-send 'Next Song'"
        ", F5, exec, playerctl previous && notify-send 'Previous Song'"
        ", F7, exec, playerctl play-pause && notify-send 'Pause/Play Toggled'"
        ", F8, exec, playerctl stop && notify-send 'Music Stopped'"

        ", F4, workspace, 3"
        ", XF86Tools, workspace, 3"
      ]
      ++ workspaces;
  };
}
