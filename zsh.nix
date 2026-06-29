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
    enableGlobalCompInit = true;
    enableFastSyntaxHighlighting = true;
    enableFzfCompletion = true;
    enableFzfGit = true;
    enableFzfHistory = true;
    histFile = "$HOME/.zsh_history";
    histSize = 100000;
    promptInit = ''
      PROMPT=$'%{\e[97m%}[%{\e[m%}%{\e[92m%}%n%{\e[m%}%{\e[32m%}@%{\e[m%}%{\e[92m%}%m%{\e[m%}:%{\e[92m%}%~%{\e[m%}%{\e[97m%}]%{\e[m%}%{\e[97m%}%#%{\e[m%} '
    '';
    interactiveShellInit = ''
      eval "$(direnv hook zsh)"

      bindkey -v
      export KEYTIMEOUT=1
    '';
  };
}
