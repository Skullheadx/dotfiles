{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.my.x11;
in {
  options.my.x11.enable = lib.mkEnableOption "X11 + dwm + sxhkd + slstatus";

  config = lib.mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "gameoflife";
        clock = "%c";
        vi_mode = true;
        vi_default_mode = "insert";
        numlock = true;
        bigclock = "en";
        bigclock_seconds = true;
      };
    };

    services.dunst = {
      enable = true;
    };

    services.xserver = {
      enable = true;
      autorun = true;
      enableTearFree = true;
      windowManager.dwm.enable = true;
      desktopManager.runXdgAutostartIfNone = false;
      displayManager = {
        setupCommands = "";
        sessionCommands = ''
          #!/bin/sh
          ${pkgs.xrandr}/bin/xrandr --output DP-3 --primary --mode 2560x1440 --rate 180 --pos 0x0 --output DP-2 --mode 1920x1080 --rate 160 --pos 2560x360
          ${pkgs.feh}/bin/feh --no-fehbg --bg-fill '/home/${username}/Wallpapers/Daniel_in_the_Lions_Den_by_Briton_Riviere.jpg'
        '';
      };
      xkb = {
        layout = "us";
        options = "caps:escape";
      };
      config = ''
        Section "InputClass"
          Identifier "Kinesis Advantage 360"
          MatchIsKeyboard "on"
          MatchVendor "Kinesis"
          Option "XkbModel" "kinesis"
          Option "XkbLayout" "us"
        EndSection
      '';
    };

    services.picom = {
      enable = true;
    };

    hjem.users.${username} = {
      files = {
        ".config/sxhkd/sxhkdrc".text = builtins.readFile (
          pkgs.replaceVars ../../dotfiles/sxhkd/sxhkdrc {
            inherit (pkgs) dmenu st surf pamixer maim xdotool xclip sfeed rmpc mpc librewolf;
            lockscreen = pkgs.lock-screen;
          }
        );
      };
    };

    systemd.user.services.sxhkd = {
      description = "Simple X Hot Key Daemon (sxhkd)";

      path = with pkgs; [
        dmenu
        st

        pamixer

        maim
        xdotool
        xclip

        lock-screen

        sfeed

        rmpc
        mpc

        surf
        librewolf
        surf_search
      ];

      environment = {
        SFEED_PLUMBER = "surf";
        SFEED_URL_FILE = "/home/${username}/.local/share/sfeed/sfeed_read_url_file";
      };

      serviceConfig = {
        ExecStart = "${pkgs.sxhkd}/bin/sxhkd";
        Restart = "on-failure";
      };
      wantedBy = ["graphical-session.target"];
    };

    systemd.user.services.slstatus = {
      description = "slstatus bar";
      wantedBy = ["graphical-session.target"];

      path = with pkgs; [
        pamixer
        scrolling-title
      ];

      serviceConfig = {
        ExecStart = "${pkgs.slstatus}/bin/slstatus";

        Restart = "always";
        RestartSec = "1s";
      };
    };
  };
}
