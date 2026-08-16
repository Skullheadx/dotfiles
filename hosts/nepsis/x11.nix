{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
    ./lockscreen.nix
  ];

  environment.systemPackages = with pkgs; [
    st
    dmenu
    sxhkd
    slstatus
    scrolling-title
    surf
    surf_search
    sent
  ];

  services.xserver = {
    enable = true;
    autorun = true;

    # Just works
    enableTearFree = true;

    # Overlay to use my-dwm
    windowManager.dwm.enable = true;

    # TODO: Remember what this is for
    desktopManager.runXdgAutostartIfNone = false;

    # Wallpaper
    displayManager = let
      backgroundImage = toString ../../Daniel_in_the_Lions_Den_by_Briton_Riviere.jpg;
      # TODO: Test that this actually works
    in {
      setupCommands = "";
      sessionCommands = ''
        #!/bin/sh
        ${pkgs.xrandr}/bin/xrandr --output DP-3 --primary --mode 2560x1440 --rate 180 --pos 0x0 --output DP-2 --mode 1920x1080 --rate 160 --pos 2560x360
        ${pkgs.feh}/bin/feh --no-fehbg --bg-fill ${backgroundImage}
      '';
    };

    # Replace CAPS lock with ESC
    xkb = {
      layout = "us";
      options = "caps:escape";
    };

    # Keyboard on Desktop
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

  # TODO: Figure out a way to have multi monitors with diff screens.
  # Currently, one monitor will have a smaller display, which is visually distracting
  # doesn't extend full length of screen
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

  # Notifications
  services.dunst = {
    enable = true;
  };

  # Transparent terminals
  services.picom = {
    enable = true;
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
}
