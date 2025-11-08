{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    settings = {
      shell-integration = "fish";
      shell-integration-features = true;
      mouse-hide-while-typing = true;
      cursor-click-to-move = true;
      mouse-shift-capture = true;
      scrollback-limit = 10000;
      link-url = true;
      link-previews = true;
      background-opacity = 0.8;
      background-blur = true;
      window-inherit-working-directory = true;
      window-save-state = "always";
      copy-on-select = "clipboard";
      clipboard-read = "allow";
      clipboard-write = "allow";
      confirm-close-surface = false;
      auto-update = "off";
    };
  };
}
