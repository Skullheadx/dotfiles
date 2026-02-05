{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
    ../../modules/darwin/common.nix
    ./darwin.nix
  ];
}
