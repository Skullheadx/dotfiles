{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableBashCompletion = true;
    enableCompletion = true;
    enableFastSyntaxHighlighting = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableFzfHistory = true;
  };
}
