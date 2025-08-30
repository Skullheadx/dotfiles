{
  config,
  pkgs,
  ...
}: {
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

      #      bind-key -r d new-session -s dev
      #      bind-key -r m new-session -s music
      #      bind-key -r n new-session -s nixos

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
  #  home.file = {
  #    ".config/tmux/setup-sessions.sh" = {
  #      executable = true;
  #    };
  #};
}
