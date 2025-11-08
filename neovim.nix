{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
dotfiles.mutable = true;
dotfiles.path = "${config.home.homeDirectory}/.dotfiles";
  filePath = "${config.dotfiles.path}/astronvim-config";
  configSrc =
    config.lib.file.mkOutOfStoreSymlink filePath;
in {
  xdg.configFile."nvim".source = ./astronvim-config;

	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};
}
