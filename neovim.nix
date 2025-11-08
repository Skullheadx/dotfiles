{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
	home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/andrew/.dotfiles/astronvim-config";
  programs.ripgrep.enable = true;
  programs.lazygit.enable = true;
  programs.bottom.enable = true;

  # home.persistence."/persist${config.home.homeDirectory}" = {
  #   directories = [
  #     ".local/share/nvim"
  #     ".local/state/nvim"
  #     ".cache/nvim"
  #   ];
  # };

	programs.neovim = {
		enable = true;
		withPython3 = true;
		withNodeJs = true;
		defaultEditor = true;
	};
}
