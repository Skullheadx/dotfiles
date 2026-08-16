{
  pkgs,
  inputs,
  ...
}: {
  services.rsync = {
    enable = true;
  };
}
