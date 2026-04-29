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

      ".config/sxhkd/sxhkdrc".text = builtins.readFile (
        pkgs.replaceVars ./dotfiles/sxhkd/sxhkdrc {
          dmenu = pkgs.dmenu;
          st = pkgs.st;
          surf = pkgs.surf;
          pamixer = pkgs.pamixer;
          maim = pkgs.maim;
          xdotool = pkgs.xdotool;
          xclip = pkgs.xclip;
          lockscreen = pkgs.lock-screen;
        }
      );

      ".config/surf/styles/default.css".text = builtins.readFile ./dotfiles/surf/styles/default.css;

    };
    packages = with pkgs; [
      discord
      lazygit
      librewolf
      btop

      (pkgs.writeShellScriptBin "surf.sh" (
        builtins.readFile (
          pkgs.replaceVars ./dotfiles/surf/surf.sh {
            dmenu = pkgs.dmenu;
            xprop = pkgs.xprop;
            gnused = pkgs.gnused;
            coreutils = pkgs.coreutils;
          }
        )
      ))
    ];
  };

}
