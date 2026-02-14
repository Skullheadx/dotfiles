{
  config,
  pkgs,
  lib,
  customNeovim,
  username,
  homeDirectory,
  ...
}: {
  imports = [
    ../../modules/home/sh.nix
    ../../modules/home/ghostty.nix
    ../../modules/home/tmux.nix
    ../../modules/home/git.nix
    ../../modules/home/fastfetch.nix
    ../../direnv.nix
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    htop
    customNeovim.neovim
  ];

  # Work config uses zsh shell for tmux/ghostty
  programs.tmux.shell = lib.mkForce "${pkgs.zsh}/bin/zsh";
  programs.ghostty.settings.shell-integration = lib.mkForce "zsh";

  programs.info.enable = true;
  programs.man.enable = true;
  programs.home-manager.enable = true;
}
