{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Skullheadx";
        email = "admonty1@protonmail.com";
      };
      pull.rebase = true;
      url = {
        "git@github.com:".insteadOf = "https://github.com/";
      };
    };
  };
}
