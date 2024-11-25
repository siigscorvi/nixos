{ pkgs, myvars }:
{
  home-manager.users.${myvars.username} = {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      mouse = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "screen-256color";
      escapeTime = 10;
      sensibleOnTop = false;
      plugins = with pkgs; [
        # saving and restoring tmux sessions
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = ''
            # for neovim
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-capture-pane-contents 'on'
          '';
        }
        # automatic saving and restoring
#      {
#        plugin = tmuxPlugins.continuum;
#        extraConfig = ''
#          set -g @continuum-restore 'on'
#          set -g @continuum-boot 'on'
#          set -g @continuum-save-interval '30'
#        '';
#      }

        # better shortcuts for tmux sessions
        tmuxPlugins.sessionist
        # open visual selection with default applications
        tmuxPlugins.open

        {
          plugin = tmuxPlugins.yank;
          extraConfig = ''
            # set vi-mode
            set-window-option -g mode-keys vi
            # keybindings
            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
            bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel 
          '';
        }
        {
          plugin = tmuxPlugins.gruvbox;
          extraConfig = ''
            set -g @tmux-gruvbox 'dark'
          '';
        }

      ];

      extraConfig = ''
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

        bind -n 'M-h' if-shell "$is_vim" 'send-keys M-h' 'resize-pane -L 1'
        bind -n 'M-j' if-shell "$is_vim" 'send-keys M-j' 'resize-pane -D 1'
        bind -n 'M-k' if-shell "$is_vim" 'send-keys M-k' 'resize-pane -U 1'
        bind -n 'M-l' if-shell "$is_vim" 'send-keys M-l' 'resize-pane -R 1'

        bind-key -T copy-mode-vi M-h resize-pane -L 1
        bind-key -T copy-mode-vi M-j resize-pane -D 1
        bind-key -T copy-mode-vi M-k resize-pane -U 1
        bind-key -T copy-mode-vi M-l resize-pane -R 1
      '';
    };

  };

}
