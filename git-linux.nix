{
  pkgs,
  inputs,
  ...
}: {
  # Make sure to update ./dotfiles/git/config
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "Skullheadx";
        email = "andrew@montgomery.systems";
      };
      init.defaultBranch = "master";
      pull.rebase = true;
    };
  };
}
