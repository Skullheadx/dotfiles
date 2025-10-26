{
  config,
  pkgs,
  ...
}: {
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
        "1, monitor:DP-3"
        "2, monitor:DP-2"
        "3, monitor:DP-3"
        "4, monitor:DP-2"
        "5, monitor:DP-3"
        "6, monitor:DP-2"
        "7, monitor:DP-2"
        "8, monitor:DP-2"
        "9, monitor:DP-3"
        "10, monitor:DP-2"
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
      ];
      exec-once = [
        "gnome-keyring-daemon --replace --start --components=pkcs11,secrets,ssh"
        "xrandr --output DP-3 --primary"
        "app -- waybar"
        "nm-applet --indicator"
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
        "[workspace 1 silent] app -- ghostty -e tmux attach -t dev || tmux new -s dev -c ~/dev"
        "[workspace 2 silent] app -- librewolf"
        #"[workspace 3 silent] app -- ghostty -e fish -c rmpc"
        "[workspace 3 silent] app -- discord"
        "[workspace 4 silent] app -- keepassxc"
        #"[workspace 8 silent] app -- steam"
        #"[workspace 9 silent] app -- obsidian"
      ];
      windowrule = [
        "workspace 3 silent, class:(discord)"
        "workspace 6 silent, class:(steam)"
        "workspace 4 silent, class:(org.keepassxc.KeePassXC)"

        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
    };
  };
}
