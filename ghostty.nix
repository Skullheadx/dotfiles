{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      link-url = true;
      background-opacity = 0.8;
      background-blur = true;
    };
  };
}
