{ config, pkgs, ... }:
let
  hk_1440 = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Skullheadx/dotfiles/16c0b7ce0cf0a6286554a3bbe60c636871fb75c9/backgrounds/hollowknightbackground_2560x1440.png";
    hash = "sha256-NyfvBFeEkXe3Z6ZpciJlOEBOMvKQjZKoH9ji2jiqmj8=";
  };
  hk_1080 = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Skullheadx/dotfiles/16c0b7ce0cf0a6286554a3bbe60c636871fb75c9/backgrounds/hollowknightbackground_1920x1080.png";
    hash = "sha256-mCqYc4w+S8aVALo6wMyXrWtCmfw78kIEcFAhxlFNbHQ=";
  };
  testImage = pkgs.fetchurl {
    url = "https://i.redd.it/mvev8aelh7zc1.png";
    hash = "sha256-lJjIq+3140a5OkNy/FAEOCoCcvQqOi73GWJGwR2zT9w";
  };
in
{

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [
        (builtins.toString hk_1440)
        (builtins.toString hk_1080)
      ];

      wallpaper = [
        "DP-3,${builtins.toString hk_1440}"
        "DP-2,${builtins.toString hk_1080}"
      ];
    };
  };
}
