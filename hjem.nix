{ config, pkgs, ... }:
{
  imports = [
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andrew = {
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  hjem.users.andrew = {
    directory = "/home/andrew";
    files = {
      ".config/surf/styles/default.css".source = ./dotfiles/surf/styles/default.css;
      ".config/surf/script.js".source = ./dotfiles/surf/script.js;


        ".sfeed/sfeedrc".source = ./dotfiles/sfeed/sfeedrc;

    };

    packages = with pkgs; [
      discord
      lazygit
      librewolf
      btop
      mpv
      zathura
      lf
      sfeed

    ];
  };

}
