{ips, ...}: {
  services.soju = {
    adminSocket.enable = true;
    enable = true;
    listen = [
      "irc+insecure://${ips.ip_wg_homelab}:6667"
      "irc+insecure://${ips.ip_local_homelab}:6667"
    ];
    hostName = "skullheadx.com";
  };
}
