{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  filePath = "${config.dotfiles.path}/astronvim-config/init.lua";
  configSrc =
    if !config.dotfiles.mutable
    then ./init.lua
    else config.lib.file.mkOutOfStoreSymlink filePath;
in {
  home.packages = [pkgs.neovim];
  xdg.configFile."neovim/config.conf".source = configSrc;
}
