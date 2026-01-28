{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.fzf.enable = true;

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15' # minutes
        '';
      }
    ];

    mouse = true;
    escapeTime = 10;
    focusEvents = true;
    prefix = "C-j";
    baseIndex = 1;
    shell = "${pkgs.fish}/bin/fish";
    keyMode = "vi";

    extraConfig = "
        # split panes using | and -
        bind | split-window -h
        bind - split-window -v
        unbind '\"'
        unbind %

        unbind s
        bind s choose-tree -s



        # switch panes using Opt + hjkl (Vim-style)
        bind -n M-h select-pane -L
        bind -n M-j select-pane -D
        bind -n M-k select-pane -U
        bind -n M-l select-pane -R

        # don't rename windows automatically
        set-option -g allow-rename off
        
        # DESIGN TWEAKS

        # don't do anything when a 'bell' rings
        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off
        setw -g monitor-activity off
        set -g bell-action none

        # clock mode
        setw -g clock-mode-colour yellow

        # copy mode
        setw -g mode-style 'fg=black bg=red bold'

        # panes
        set -g pane-border-style 'fg=red'
        set -g pane-active-border-style 'fg=yellow'

        # statusbar
        set -g status-position bottom
        set -g status-justify left
        set -g status-style 'fg=red'

        set -g status-left ''
        set -g status-left-length 10

        set -g status-right-style 'fg=black bg=yellow'
        set -g status-right '%Y-%m-%d %H:%M '
        set -g status-right-length 50

        setw -g window-status-current-style 'fg=black bg=red'
        setw -g window-status-current-format ' #I #W #F '

        setw -g window-status-style 'fg=red bg=black'
        setw -g window-status-format ' #I #[fg=white]#W #[fg=yellow]#F '

        setw -g window-status-bell-style 'fg=yellow bg=red bold'

        # messages
        set -g message-style 'fg=yellow bg=red bold'
      ";
  };
}
