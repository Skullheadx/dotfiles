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
    };

    packages = with pkgs; [
      delta
    ];
  };
}
