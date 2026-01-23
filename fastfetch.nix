{ config, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        padding = {
          right = 1;
        };
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "datetime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "theme"
        "icons"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "battery"
        "poweradapter"
        "font"
        "cursor"
        "colors"
      ];
    };
  };
}
