{
  pkgs,
  inputs,
  config,
  ...
}: {
  # TODO: Look into emacsclient
  services.emacs = {
    enable = true;
    startWithGraphical = config.services.xserver.enable;
    install = true;
    # defaultEditor = true;
  };
}
