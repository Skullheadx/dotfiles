{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    historyLimit = 5000;
    extraConfig = ''
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Enable mouse support
      set -g mouse on

      # Set prefix to Ctrl-a
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      # Improve colors
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
  };
}
