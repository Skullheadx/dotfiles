{
  pkgs,
  input,
  ...
}: {
  programs.gnupg = {
    dirmngr.enable = true;
    agent = {
      enable = true;
      enableSSHSupport = true;
      enableBrowserSocket = true;
      settings = {
        default-cache-ttl = 86400;
        max-cache-ttl = 604800;
      };
    };
  };
}
