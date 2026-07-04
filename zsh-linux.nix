{
  config,
  pkgs,
  username,
  ...
}: {
  environment.systemPackages = with pkgs; [
    fzf
  ];

  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    loadInNixShell = true;
    nix-direnv = {
      enable = true;
    };
    silent = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestions = {
      enable = true;
      async = true;
      highlightStyle = "fg=cyan";
      strategy = [
        "history"
        "completion"
      ];
    };
    enableBashCompletion = true;
    enableCompletion = true;
    enableGlobalCompInit = true;
    enableLsColors = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
        "cursor"
        "regexp"
        "root"
        "line"
      ];
    };
    vteIntegration = true;
    # enableFzfCompletion = true;
    # enableFzfGit = true;
    # enableFzfHistory = true;
    histFile = "$HOME/.zsh_history";
    histSize = 100000;
    promptInit = ''
      PROMPT=$'%{\e[97m%}[%{\e[m%}%{\e[92m%}%n%{\e[m%}%{\e[32m%}@%{\e[m%}%{\e[92m%}%m%{\e[m%}:%{\e[92m%}%~%{\e[m%}%{\e[97m%}]%{\e[m%}%{\e[97m%}%#%{\e[m%} '
    '';
    interactiveShellInit = ''
      setopt autocd extendedglob nomatch notify

      bindkey -v
      export KEYTIMEOUT=20
    '';
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.${username}.shell = pkgs.zsh;
}
