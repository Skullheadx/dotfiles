{
  config,
  pkgs,
  ...
}: {
  programs.thunderbird = {
    enable = true;
    nativeMessagingHosts = [pkgs.protonmail-bridge];
    profiles."default" = {
      isDefault = true;
    };
  };
}
