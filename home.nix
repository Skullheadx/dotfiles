{ config, pkgs, nur,inputs,  ... }:

{
  imports = [
    ./sh.nix
    # ./librewolf.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "andrewmontgomery";
  home.homeDirectory = "/Users/andrewmontgomery/";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";


  home.packages = with pkgs; [
    htop
  ];

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
  programs.tmux = {
    enable = true;
    escapeTime=10;
    extraConfig = "
      set -g mouse on
      ";
  };
  programs.ghostty = {
    settings = {
  theme = "catppuccin-mocha";
  font-size = 14;
  background-blur=true;
      link-url=true;
      link-previews=true;
      shell-integration="fish";
      shell-integration-features=true;
      auto-update="off";
    };
    themes = {
      catppuccin-mocha = {
    background = "1e1e2e";
    cursor-color = "f5e0dc";
    foreground = "cdd6f4";
    palette = [
      "0=#45475a"
      "1=#f38ba8"
      "2=#a6e3a1"
      "3=#f9e2af"
      "4=#89b4fa"
      "5=#f5c2e7"
      "6=#94e2d5"
      "7=#bac2de"
      "8=#585b70"
      "9=#f38ba8"
      "10=#a6e3a1"
      "11=#f9e2af"
      "12=#89b4fa"
      "13=#f5c2e7"
      "14=#94e2d5"
      "15=#a6adc8"
    ];
    selection-background = "353749";
    selection-foreground = "cdd6f4";
  };
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
