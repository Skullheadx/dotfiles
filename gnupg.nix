{
  pkgs,
  input,
  ...
}: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
