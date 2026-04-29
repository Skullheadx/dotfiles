{ config, pkgs, ... }:
{
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
        		${pkgs.sxhkd}/bin/sxhkd &
        		${pkgs.slstatus}/bin/slstatus &
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

}
