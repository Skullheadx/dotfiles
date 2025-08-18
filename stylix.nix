{ config, pkgs, ... }:
{

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  stylix.polarity = "dark";
  stylix.image = ./backgrounds/hollowknightbackground_2560x1440.png;
}
