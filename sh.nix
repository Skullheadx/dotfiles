{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    interactiveShellInit = ''
      shopt -s autocd
      shopt -s cdable_vars
      shopt -s cdspell
      shopt -s dirspell
      shopt -s checkjobs
      shopt -s cmdhist
      shopt -s histappend
      shopt -s globstar
      shopt -s extglob
    '';
#    promptInit = ''
#      PS1="\[\e[97m\][\[\e[m\]\[\e[92m\]\u\[\e[m\]\[\e[32m\]@\[\e[m\]\[\e[92m\]\h\[\e[m\]:\[\e[92m\]\w\[\e[m\]\[\e[97m\]]\[\e[m\]\[\e[97m\]\\$\[\e[m\] "
#    '';
    shellAliases = {
      nix-sw = "sudo nixos-rebuild switch --flake .";
      nix-upd-sl = "sudo nix flake update my-slstatus my-dwm my-surf my-st my-dmenu";

    };
  };

  environment.etc."inputrc".text = ''
    set editing-mode vi
    set show-mode-in-prompt on
    set keyseq-timeout 10

    set vi-ins-mode-string "\1\e[5 q\2"
    set vi-cmd-mode-string "\1\e[2 q\2"


    set colored-stats on
    set colored-completion-prefix on
    set blink-matching-paren on

    set completion-ignore-case on
    set show-all-if-ambiguous on
    set completion-map-case on
  '';
}
