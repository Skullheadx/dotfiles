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

      ".config/sxhkd/sxhkdrc".text = ''
super + space
	${pkgs.dmenu}/bin/dmenu_run

super + Return
	${pkgs.st}/bin/st	

super + b
	${pkgs.librewolf}/bin/librewolf

XF86AudioRaiseVolume
    ${pkgs.pamixer}/bin/pamixer -i 5

XF86AudioLowerVolume
    ${pkgs.pamixer}/bin/pamixer -d 5

XF86AudioMute
    ${pkgs.pamixer}/bin/pamixer -t

super + s
    ${pkgs.maim}/bin/maim -i $(${pkgs.xdotool}/bin/xdotool getactivewindow) | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png

super + shift + s
	${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png

super + l
	${pkgs.lock-screen}/bin/lock-screen 

      '';
    };
    packages = with pkgs; [
      discord
lazygit
    ];
  };

}
