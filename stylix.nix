{ config, pkgs, ... }:
{

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";
    #image = ./backgrounds/hollowknightbackground_2560x1440.png;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    targets = {
      fish.enable = true;

      gtk.enable = true;
      qt.enable = true;

      vim.enable = true;
      neovim.enable = true;

      kitty.enable = true; # Kitty terminal
      ghostty.enable = true;
      waybar.enable = true;
      rofi.enable = true;
      tmux.enable = true;
      hyprlock.enable = true;
      hyprland.enable = true;
      hyprpaper.enable = true;
      fzf.enable = true;
      dunst.enable = true;

    };

  };
}
