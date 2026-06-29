{
  config,
  pkgs,
  ...
}: {
  # home.username = username;
  # home.homeDirectory = homeDir;
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file = {
    ".config/senpai/senpai.scfg".source = ./dotfiles/senpai/senpai.scfg;
  };

  programs.emacs = {
    enable = true;
    extraConfig = ''
      ;;; -*- lexical-binding: t -*-
      (custom-set-variables
       ;; custom-set-variables was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       '(custom-enabled-themes '(modus-vivendi-tinted))
       '(rcirc-default-nick "Skullheadx")
       '(rcirc-server-alist
         '(("irc.libera.chat" :port 6697 :channels ("#emacs" "#lobsters" "#openbsd")
            :encryption tls))))
      (custom-set-faces
       ;; custom-set-faces was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       )
      (global-set-key (kbd "C-c l") #'org-store-link)
      (global-set-key (kbd "C-c a") #'org-agenda)
      (global-set-key (kbd "C-c c") #'org-capture)
      (setq org-agenda-files '("~/org"))
      (setq org-todo-keywords
            '((sequence
               "TODO(t)"
               "NEXT(n)"
               "WAIT(w@)"
               "|"
               "DONE(d)"
               "CANCELLED(c@)")))
      (setq org-capture-templates
            '(("t" "Todo" entry
               (file "~/org/inbox.org")
               "* TODO %?\n%U")))
      (setq org-agenda-custom-commands
            '(("n" "Next Actions"
               todo "NEXT")))
      (setq org-log-done 'time)

      (fido-vertical-mode 1)

      ;; Nix syntax
      (use-package nix-mode
        :mode "\\.nix\\'")

      ;; LSP
      (use-package lsp-mode
        :hook (nix-mode . lsp-deferred))

      ;; Optional UI helpers
      (use-package lsp-ui
        :commands lsp-ui-mode)

      ;; Formatting
      (use-package apheleia
        :config
        (setf (alist-get 'nix-mode apheleia-mode-alist) 'alejandra)
        (apheleia-global-mode +1))
    '';
    extraPackages = epkgs:
      with epkgs; [
        nix-mode
        lsp-mode
        lsp-ui
        apheleia
      ];
  };
}
