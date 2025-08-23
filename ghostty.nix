{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    settings = {
      shell-integration = "zsh";
      shell-integration-features = true;
      mouse-hide-while-typing = true;
      link-url = true;
      background-opacity = 0.8;
      background-blur = true;
      clipboard-read = "allow";
      clipboard-write = "allow";
      confirm-close-surface = false;
      auto-update = "off";

    };
  };
}
