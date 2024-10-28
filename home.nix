{ config, pkgs, inputs, ... }:

{

  home.username = "siigs";
  home.homeDirectory = "/home/siigs";

  programs = {
    home-manager.enable = true;
    git.enable = true;
    alacritty.enable = true;
    lf.enable = true;
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    programs.neovin.extraLuaConfig = ''
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


      '' ++
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

      '';

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-bash
        p.tree-sitter-lua
      ]))
    ];
  };

  home.stateVersion = "24.05";
}
