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
                        set -g history-limit 10000
                        set -g prefix C-a
                        unbind C-b
                        bind C-a send-prefix

                        bind | split-window -h
                        bind - split-window -v


                            # Pane navigation (vim-style)
                            bind h select-pane -L
                            bind j select-pane -D
                            bind k select-pane -U
                            bind l select-pane -R

                            # Pane resizing with Shift + vim keys
                            bind -r H resize-pane -L 5
                            bind -r J resize-pane -D 5
                            bind -r K resize-pane -U 5
                            bind -r L resize-pane -R 5
                            bind s choose-session
                            bind w choose-window
            # Auto-create sessions if they don't exist
            if-shell "tmux has-session -t dev   2>/dev/null" "" "new-session -ds dev -c ~/dev 'fish'"
            if-shell "tmux has-session -t music 2>/dev/null" "" "new-session -ds music 'rmpc'"
            if-shell "tmux has-session -t nixos 2>/dev/null" "" "new-session -ds nixos -c ~/.dotfiles/nixos 'nvim .'"

                  # Quick binds for session switching
                  bind d switch-client -t dev
                  bind m switch-client -t music
                  bind n switch-client -t nixos
      bind -n C-1 select-window -t 1
      bind -n C-2 select-window -t 2
      bind -n C-3 select-window -t 3
      bind -n C-4 select-window -t 4
      bind -n C-5 select-window -t 5
      bind -n C-6 select-window -t 6
      bind -n C-7 select-window -t 7
      bind -n C-8 select-window -t 8
      bind -n C-9 select-window -t 9
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
