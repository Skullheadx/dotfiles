{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "xterm-256color";
    historyLimit = 10000;
    sensibleOnTop = false;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      vim-tmux-navigator # Deep Neovim integration for seamless pane navigation
      {
        plugin = resurrect; # Session persistence
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum; # Auto-save sessions
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10' # Save every 10 minutes
        '';
      }
    ];
    extraConfig = ''
      # Basic settings for usability
      set -g mouse on
      set -g base-index 1
      set -g pane-base-index 1
      set -g status-style bg=black,fg=cyan
      set -g prefix C-a
      unbind C-b
      bind C-a send-prefix

      # Keybindings for easier navigation
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

      # Fish-friendly clipboard integration
      set -g set-clipboard on
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"

      # Session initialization script
      set -g @tmux-resurrect-restore-script '${config.home.homeDirectory}/.config/tmux/setup-sessions.sh'
    '';
  };

  home.packages = with pkgs; [
	tmux
	xclip
  ];


  # Create session setup script
  home.file.".config/tmux/setup-sessions.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Ensure tmux is running
      if ! tmux has-session 2>/dev/null; then
        # Dev session: terminal with Fish
        tmux new-session -d -s dev -c $HOME
        tmux send-keys -t dev:1 "fish" C-m

        # Music session: rmpc
        tmux new-session -d -s music -c $HOME
        tmux send-keys -t music:1 "rmpc" C-m

        # NixOS config session: open ~/.dotfiles/nixos with Neovim
        tmux new-session -d -s nixos -c $HOME/.dotfiles/nixos
        tmux send-keys -t nixos:1 "nvim ." C-m
      fi

      # Attach to dev session by default
      tmux attach-session -t dev
    '';
};
}
