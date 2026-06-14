{
  config,
  pkgs,
  ...
}: {
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
        ${pkgs.feh}/bin/feh --no-fehbg --bg-fill '/home/andrew/Wallpapers/Daniel_in_the_Lions_Den_by_Briton_Riviere.jpg'
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

  hjem.users.andrew = {
    files = {
      ".config/sxhkd/sxhkdrc".text = builtins.readFile (
        pkgs.replaceVars ./dotfiles/sxhkd/sxhkdrc {
          dmenu = pkgs.dmenu;
          st = pkgs.st;
          surf = pkgs.surf;
          pamixer = pkgs.pamixer;
          maim = pkgs.maim;
          xdotool = pkgs.xdotool;
          xclip = pkgs.xclip;
          lockscreen = pkgs.lock-screen;
          sfeed = pkgs.sfeed;
          rmpc = pkgs.rmpc;
          mpc = pkgs.mpc;
          librewolf = pkgs.librewolf;
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
      SFEED_URL_FILE = "/home/andrew/.local/share/sfeed/sfeed_read_url_file";
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
}
