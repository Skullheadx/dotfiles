{
  config,
  pkgs,
  ...
}: {
  home.username = "andrew";
  home.homeDirectory = "/Users/andrew/";
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/senpai/senpai.scfg".source = ./dotfiles/senpai/senpai.scfg;
  };
}
