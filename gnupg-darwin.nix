{
  pkgs,
  input,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pinentry-curses
    pinentry_mac
  ];

  # You MUST use the gnupg conf set in ".gnupg/gpg-agent.conf"
  programs.gnupg = {
    agent = {
      enable = true;
      enableSSHSupport = true;
      # enableBrowserSocket = true;
      # settings = {
      #   default-cache-ttl = 86400;
      #   max-cache-ttl = 604800;
      # };
    };
  };
}
