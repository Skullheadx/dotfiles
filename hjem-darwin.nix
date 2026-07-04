{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
  ];

  hjem.users.${username} = {
    directory = "/Users/${username}";
    files = {
      ".config/ghostty/config.ghostty".source = ./dotfiles/ghostty/config.ghostty;
      ".config/git/config".source = ./dotfiles/git/config;
      "Library/Application Support/lazygit/config.yml".source = ./dotfiles/lazygit/config.yml;
      ".config/tealdeer/config.toml".source = ./dotfiles/tealdeer/config.toml;
    };

    packages = with pkgs; [
      delta
    ];
  };
}
