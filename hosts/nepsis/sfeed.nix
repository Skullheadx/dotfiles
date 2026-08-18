{pkgs, ...}: {
  systemd.user.services."sfeed-update" = {
    description = "Update sfeed RSS feeds";
    path = with pkgs; [
      curl
      sfeed
      coreutils
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.sfeed}/bin/sfeed_update";
    };
  };

  systemd.user.timers."sfeed-update" = {
    description = "Run sfeed_update daily";
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
    wantedBy = ["timers.target"];
  };
}
