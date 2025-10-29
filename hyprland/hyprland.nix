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
    settings = {
      animations.enabled = true;
      animation = [
        "specialWorkspaceIn, 1, 10, default, slide top"
        "specialWorkspaceOut, 1, 10, default, slide bottom"
      ];
      general = {
        layout = "master";
      };
      master = {
        new_on_top = true;
      };
      cursor = {
        enable_hyprcursor = true;
        default_monitor = "DP-3";
      };
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
      env = [
        "EDITOR,nvim"
        "VISUAL,nvim"
        # --- AMD GPU (critical) ---
        "LIBVA_DRIVER_NAME,radeonsi" # VAAPI video accel
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,wayland"
        "WLR_BACKEND,wayland"
        "WLR_RENDERER_ALLOW_SOFTWARE,1" # Fallback if needed
        "WLR_NO_HARDWARE_CURSORS,1" # Fix cursor bugs on some AMD

        #Performance & VRR ---
        "WLR_DRM_NO_ATOMIC,1" # Fix blank screen on some drivers
        "AMD_VULKAN_ICD,RADV" # Force RADV (Mesa Vulkan)
        "__GLX_VENDOR_LIBRARY_NAME,mesa"

        #Input & Scaling ---
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Bibata-Original-Classic"
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "GDK_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"

        # Polish ---
        "WLR_DRM_DEVICES,/dev/dri/card0" # Multi-GPU: force primary
        "MOZ_ENABLE_WAYLAND,1" # Firefox
        "ELECTRON_OZONE_PLATFORM_HINT,auto" # Electron apps
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
        "7, monitor:DP-3"
        "8, monitor:DP-2"
        "9, monitor:DP-3"
        "10, monitor:DP-2"
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"
        "special:term, monitor:DP-3, gapsout:0, gapsin:0, border:false"
        "special:music, monitor:DP-3, gapsout:0, gapsin:0, border:false"
        "special:password, monitor:DP-3, gapsout:0, gapsin:0, border:false"
      ];
      exec-once = [
        "gnome-keyring-daemon --replace --start --components=pkcs11,secrets,ssh"
        "xrandr --output DP-3 --primary"
        "waybar"
        "nm-applet --indicator"
        "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
        "[workspace 1 silent]  ghostty -e tmux attach -t dev || tmux new -s dev -c ~/dev"
        "[workspace 2 silent] librewolf"
        #"[workspace 3 silent] ghostty -e fish -c rmpc"
        "[workspace 3 silent] discord"
        "[workspace special:password silent] keepassxc"
        "[workspace special:term silent] ghostty"
        "[workspace special:music silent] ghostty -e rmpc"
        #"[workspace 8 silent] steam"
        #"[workspace 9 silent] obsidian"
      ];
      windowrule = [
        "workspace 3 silent, class:(discord)"
        "workspace 6 silent, class:(steam)"

        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"

        "float,      onworkspace:special"
        "center,     onworkspace:special"
        "size 800 600, onworkspace:special"
        "rounding 12, onworkspace:special"
        "noborder,   onworkspace:special" # or "border 0"
        #"animation slide top,   onworkspace:special"
        #"animation fade,        onworkspace:special, 0.9"
      ];
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
    };
  };
}
