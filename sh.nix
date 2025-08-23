{
  config,
  lib,
  pkgs,
  ...
}:
let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
in
{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true; # Enables zsh-completions
    autosuggestion.enable = true; # Enables zsh-autosuggestions
    syntaxHighlighting.enable = true; # Enables zsh-syntax-highlighting
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" # Git plugin
        "colored-man-pages" # Colored man pages
        "alias-finder" # Find aliases for commands
      ];
      theme = "";
    };
    initContent = ''
      # Powerlevel10k configuration
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
	source ${./.p10k.zsh}
      # Initialize zoxide
      eval "$(zoxide init zsh)"

      # Initialize fzf
      source <(fzf --zsh)

      # Source fzf-tab (needs to be after fzf)
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      # Custom aliases
      alias ll="ls -la"
      alias gs="git status"

	bindkey '^ ' autosuggest-execute
    '';  };
}
