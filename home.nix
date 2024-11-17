{ config, pkgs, inputs, ... }:

{

  home.username = "siigs";
  home.homeDirectory = "/home/siigs";

  programs = {
    home-manager.enable = true;
    starship.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    lf.enable = true;
  };
  
  home.packages = [ pkgs.zsh ];

  home.file.".config/starship.toml" = {
    source = ./configfiles/starship.toml;
  };

  home.file.".config/polybar/config.ini" = {
    source = ./configfiles/polybar.ini;
  };
  
  home.file.".config/xborders/config.json" = {
    source = ./configfiles/xborders.json;
    force = true;
  };

  home.file.".config/picom/picom.conf" = {
    source = ./configfiles/picom.conf;
    force = true;
  };

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
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '30'
        '';
      }

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
    
  programs.zsh = {
    enable = true;

    # options
    history = {
      append = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    # plugins
    autocd = true;
    autosuggestion = {
      enable = true;
      #highlight = "fg=#ff00ff,bg=cyan,bold,underline";
      strategy = [
        "history"
        "completion"
        "match_prev_cmd"
      ];
    };
    # dotDir = "";
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    # additional stuff for .zshrc
#    initExtraFirst = ''
#      if [ -z "$TMUX" ]
#      then
#          tmux attach -t default || tmux new -s default
#      fi
#    '';

    initExtra = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';


    # aliases
    shellAliases = {
      gst = "git status";
      gc = "git commit";
      gp = "git push";
      ga = "git add";
      gd = "git diff";

      con = "vi ~/.dotfiles";
      cdcon = "cd  ~/.dotfiles";

      t = "tmux";
      ta = "tmux a";      
      ff = "fastfetch";

      nhs = "nh os switch -H siigs ~/.dotfiles/";
#      vnc0 = "x0vncserver -rfbauth ~/.config/tigervnc/passwd -Display=:0";
    };
  };

  programs.fzf.enableZshIntegration = true;

  programs.git = {
    enable = true;
    userEmail = "s76rhart@uni-bonn.de";
    userName = "siigscorvi";
    extraConfig = {
      color.ui = true;
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com:siigscorvi" = { 
          insteadOf = "https://github.com/siigscorvi";
        };
      };
    };
  };
  
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    font = {
      normal.family = "JetBrainsMono Nerd Font Mono";
      bold = { style = "Bold"; };
      size = 11;
    };
    general = {import = ["~/.config/alacritty/themes/themes/gruvbox_dark.toml"];};
  };

  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      nil # nix lang - language server
      lua-language-server # lua language server
      cmake-language-server # CMAKE language server
      ccls # C/C++/Objective-C language server
      pylyzer # python language server. can also try https://github.com/python-lsp/python-lsp-server + https://github.com/python-rope/pylsp-rope in the future
#     rPackages.languageserver # R language server
      ltex-ls # markdown and LaTeX language server for grammar checks (also supports Quarto, git commit messages, R Markdown) 
#     markdown-oxide # lsp for personal-knowledge management system like obsidian
      marksman # lsp for markdown-specific features 
#     gopls # official go-lang language server
#     golangci-lint-langserver # language server for the "golangci linter"
#     golangci-lint # linter for go - use golangci-lint-langserver with this?
#     superhtml # html language server
#     asm-lsp # nasm/gas/go assembly lsp
#     rust-analyzer # rust language server
      bash-language-server # bash language server
#     dockerfile-language-server-nodejs # docker file/compose language server by docker developer. !!only works with nodejs
      taplo # toml toolkit, with language server
      yaml-language-server # yaml language server
    ];

    plugins = with pkgs.vimPlugins; [
      {
        # lsp configs for all language server, so I dont have to set it up everything for every language server
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      # "completion engine for nvim"
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      # support for lsps in nvim-cmp and additional signature highlihgting on completion
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-path
      # nvim-cmp source for luasnips. see below
      cmp_luasnip
      # luasnips allows to create snippets of code to use in code
      luasnip
       
      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      plenary-nvim
      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }
      telescope-fzf-native-nvim
      telescope-file-browser-nvim
      nvim-web-devicons
       
      {
        plugin = mason-nvim;
        config  = toLua "require(\"mason\").setup()";
      }
      ltex_extra-nvim

      nvim-treesitter.withAllGrammars
      # needed for tmux-resurrect to save nvim sessions
      # vim-obsession
      # needed for vim-like tmux navigation
      {
        plugin = tmux-nvim;
        config = toLuaFile ./nvim/plugin/tmux_nav.lua;
      }

      {
        plugin = undotree;
      }


      vim-startuptime

    ];

    extraLuaConfig =
    # set.lua 
    ''
      -- show current line number
      vim.opt.nu = true
      -- show relative line number in relation to cursor
      vim.opt.relativenumber = true

      -- set tab size to 2
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      -- smartindent and force autoindent
      vim.opt.autoindent = true
      vim.opt.smartindent = true

      -- force linewrap
      vim.opt.wrap = true

      -- force enable 24 bit coloring
      -- vim.set.termguicolors = true
      -- disabled since vim will set it automatically if 24 bit coloring is available. Enable again if coloring doesnt work for some reason

      -- keep 8 lines above and below cursor
      vim.opt.scrolloff = 8
      -- sign column (for example for git plugin, showing git signs) always on, for consistency
      vim.opt.signcolumn = "yes"
      -- add @ as a valid character in filenames (I don't really know why)
      vim.opt.isfname:append("@-@")

      -- time without input until swapped file is written to disk. this is safer
      vim.opt.updatetime = 50
      '' 
      +
    # keymaps.lua
      ''
      -- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim so that mappings are correct.
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"

      -- when scrolling with <C-d> or <C-u>, cursor stays at its position
      vim.keymap.set("n", "<C-d>", "<C-d>zz")
      vim.keymap.set("n", "<C-u>", "<C-u>zz")

      -- when moving through search terms, cursor stays at its position
      vim.keymap.set("n", "n", "nzzzv")
      vim.keymap.set("n", "N", "Nzzzv")

      --- keymaps for telescope. For some reason, when moving them into telescope.lua they no longer work
      --- possibly because of the order they are loaded? since undotree had some strange behavior aswell
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

      -- for copying to the system clipboard
      vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
      vim.keymap.set("n", "<leader>Y", [["+Y]])

      -- for deleting to void register
      vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

      -- replace current word
      vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

      '';
  };

  home.stateVersion = "24.05";
}
