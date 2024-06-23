{ config, pkgs, lib, inputs, ... }:
with lib;
let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.module.tmux;
in {
  imports = [
    # Paths to other modules.
    # Compose this module out of smaller ones.
  ];

  options.module.tmux = {
    # Option declarations.
    # Declare what settings a user of this module module can set.
    # Usually this includes a global "enable" option which defaults to false.
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    # Option definitions.
    # Define what other settings, services and resources should be active.
    # Usually these depend on whether a user of this module chose to "enable" it
    # using the "option" above.
    # Options for modules imported in "imports" can be set here.
    programs.tmux.enable = true;
    programs.tmux.extraConfig = ''
      set -ga terminal-overrides ",screen-256color*:Tc"
      set-option -g default-terminal "screen-256color"
      set -s escape-time 0

      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix
      set -g status-style 'bg=#333333 fg=#5eacd3'

      bind r source-file ~/.tmux.conf
      set -g base-index 1

      set-window-option -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      # vim-like pane switching
      bind -r ^ last-window
      bind -r l select-pane -U
      bind -r k select-pane -D
      bind -r j select-pane -L
      bind -r ö select-pane -R

      # forget the find window.  That is for chumps
      bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"
    '';
    home.file."bin/tmux-sessionizer" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            selected=$(find ~/ ~/work ~/personal ~/personal/projects -mindepth 1 -maxdepth 1 -type d | fzf)
        fi

        if [[ -z $selected ]]; then
            exit 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
            tmux new-session -s $selected_name -c $selected
            exit 0
        fi

        if ! tmux has-session -t=$selected_name 2> /dev/null; then
            tmux new-session -ds $selected_name -c $selected
        fi

        tmux switch-client -t $selected_name
      '';
    };
  };
}
