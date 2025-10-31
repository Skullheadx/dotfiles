{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "xterm-ghostty";
    historyLimit = 10000;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    mouse = true;
    newSession = true;

    extraConfig = ''
                        unbind C-b
                        set -g prefix M-b
                        bind M-b send-prefix

                        unbind %
                        unbind '"'
                        bind -n M-\\ split-window -h -c "#{pane_current_path}"
                        bind -n M-- split-window -v -c "#{pane_current_path}"

                        bind -n M-c new-window -c "#{pane_current_path}"
                        bind -n M-q kill-window
                        bind -n M-w kill-pane
                        bind -n M-r command-prompt -I "#W" "rename-window '%%'"
      bind -n M-Space display-popup -E "\
          tmux list-sessions -F '#{session_name}' 2>/dev/null | \
          fzf --reverse \
              --header='Alt+Space → Switch or Create Session' \
              --border=rounded \
              --height=40% \
              --print-query \
              --preview='tmux capture-pane -p -t {} 2>/dev/null || echo \"(new session)\"' | \
          tail -1 | \
          xargs -I {} sh -c '\
            if tmux has-session -t \"{}\" 2>/dev/null; then \
              tmux switch-client -t \"{}\"; \
            else \
              tmux new-session -d -s \"{}\" && tmux switch-client -t \"{}\"; \
            fi' \
                        set -g escape-time 10
                        set -s escape-time 10
                        bind -n M-1 select-window -t 1
                        bind -n M-2 select-window -t 2
                        bind -n M-3 select-window -t 3
                        bind -n M-4 select-window -t 4
                        bind -n M-5 select-window -t 5
                        bind -n M-6 select-window -t 6
                        bind -n M-7 select-window -t 7
                        bind -n M-8 select-window -t 8
                        bind -n M-9 select-window -t 9

                        bind -n M-h select-pane -L
                        bind -n M-j select-pane -D
                        bind -n M-k select-pane -U
                        bind -n M-l select-pane -R

                        bind -n M-H swap-pane -U
                        bind -n M-J swap-pane -D
                        bind -n M-K swap-pane -U
                        bind -n M-L swap-pane -D

    '';
  };

  home.packages = with pkgs; [
    tmux
  ];
}
