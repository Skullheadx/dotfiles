{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.lockscreen;
in {
  options.my.lockscreen.enable = lib.mkEnableOption "betterlockscreen with xautolock";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      betterlockscreen
      lock-screen
    ];

    programs.i3lock = {
      enable = true;
      package = pkgs.i3lock-color;
    };

    security.pam.services.betterlockscreen = {};

    services.xserver.xautolock = {
      enable = true;
      enableNotifier = true;
      notifier = "${pkgs.dunst}/bin/notify-send 'Locking in 10 seconds'";
      locker = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dimblur";
    };
  };
}
