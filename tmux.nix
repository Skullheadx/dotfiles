{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "xterm-ghostty";
    historyLimit = 10000;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-j";
    shortcut = "j";

    extraConfig = ''
      bind | split-window -h
      bind - split-window -v
    '';
  };

  home.packages = with pkgs; [
    tmux
  ];
}
