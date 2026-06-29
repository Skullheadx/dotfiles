{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
  ];

  hjem.users.${username} = {
    files = {
      ".config/senpai/senpai.scfg".source = ./dotfiles/senpai/senpai.scfg;
    };

    packages = with pkgs; [
      senpai
    ];
  };
}
