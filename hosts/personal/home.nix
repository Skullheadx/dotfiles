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
    ../../modules/home/librewolf.nix
    ../../direnv.nix
    ../../ranger.nix
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    htop
    customNeovim.neovim
    go
    qbittorrent
    direnv
    audacity
  ];

  # Personal config uses fish shell for tmux/ghostty
  programs.tmux.shell = lib.mkForce "${pkgs.fish}/bin/fish";
  programs.ghostty.settings.shell-integration = lib.mkForce "fish";

  programs.info.enable = true;
  programs.man.enable = true;
  programs.home-manager.enable = true;
}
