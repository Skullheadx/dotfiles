{
  config,
  pkgs,
  username,
  ...
}: {
  hjem.users.${username} = {
    directory = "/Users/${username}";
    files = {
      ".config/ghostty/config.ghostty".source = ./dotfiles/ghostty/config.ghostty;

      # Ensure to update this with git-linux.nix
      ".config/git/config".source = ./dotfiles/git/config;
      ".config/tealdeer/config.toml".source = ./dotfiles/tealdeer/config.toml;

      # Requires delta package
      "Library/Application Support/lazygit/config.yml".source = ./dotfiles/lazygit/config.yml;

      # Must be enabled with gnupg-darwin.nix
      ".gnupg/gpg-agent.conf".source = ./dotfiles/gnupg/gpg-agent.conf;
    };
  };
}
