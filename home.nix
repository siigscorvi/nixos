{ config, pkgs, inputs, ... }:

{

  home.username = "siigs";
  home.homeDirectory = "/home/siigs";

  programs = {
    home-manager.enable = true;
    git.enable = true;
    zsh.enable = true;
    starship.enable = true;
    alacritty.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    lf.enable = true;
  };
  
  home.packages = [ pkgs.zsh ];

  programs.tmux = {
   enable = true;
   baseIndex = 1;
   mouse = true;
   shell = "${pkgs.zsh}/bin/zsh";
   sensibleOnTop = false;
   extraConfig = ''

   '';
  };
    
  programs.zsh = {

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
    initExtraFirst = ''
      if [ -z "$TMUX" ]
      then
          tmux attach -t default || tmux new -s default
      fi
      # In .zshrc

      bindkey -v
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
      
      nhs = "nh os switch -H siigs ~/.dotfiles/";
#      vnc0 = "x0vncserver -rfbauth ~/.config/tigervnc/passwd -Display=:0";
    };
  };

  programs.fzf.enableZshIntegration = true;

  home.file.".config/starship.toml" = {
    source = ./configfiles/starship.toml;
  };

  programs.git = {
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
  
  programs.alacritty.settings = {
    font = {
      normal.family = "JetBrainsMono Nerd Font Mono";
      bold = { style = "Bold"; };
      size = 11;
    };
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
      lua-language-server
      xclip
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

      -- open Explorer
      vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

      -- when scrolling with <C-d> or <C-u>, cursor stays at its position
      vim.keymap.set("n", "<C-d>", "<C-d>zz")
      vim.keymap.set("n", "<C-u>", "<C-u>zz")

      -- when moving through search terms, cursor stays at its position
      vim.keymap.set("n", "n", "nzzzv")
      vim.keymap.set("n", "N", "Nzzzv")

      -- for copying to the system clipboard
      vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
      vim.keymap.set("n", "<leader>Y", [["+Y]])

      -- for deleting to void register
      vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

      -- replace current word
      vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

      '';

    plugins = with pkgs.vimPlugins; [
#     {
#        plugin = nvim-lspconfig;
#        config = toLuaFile ./nvim/plugin/lsp.lua;
#     }
      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }
      telescope-fzf-native-nvim

      nvim-treesitter.withAllGrammars

    ];
  };

  home.stateVersion = "24.05";
}
