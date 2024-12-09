{ pkgs, vars, ... }:

{
  home-manager.users.${vars.username} = {
    programs.ripgrep.enable = true;

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

        cmake-language-server 
        ccls # C/C++/Objective-C language server

        ltex-ls # markdown and LaTeX language server for grammar checks (also supports Quarto, git commit messages, R Markdown) 
#     markdown-oxide # lsp for personal-knowledge management system like obsidian
        marksman # lsp for markdown-specific features 

#     gopls # official go-lang language server
#     golangci-lint-langserver # language server for the "golangci linter"
#     golangci-lint # linter for go - use golangci-lint-langserver with this?

#     superhtml # html language server

#     asm-lsp # nasm/gas/go assembly lsp

#     rust-analyzer

        bash-language-server 

#     dockerfile-language-server-nodejs # docker file/compose language server by docker developer. !!only works with nodejs

        taplo # toml toolkit, with language server
        yaml-language-server # yaml language server
      ];

      plugins = with pkgs.vimPlugins; [
        {
          # lsp configs for all language server, so I dont have to set it up everything for every language server
          plugin = nvim-lspconfig;
          config = toLuaFile ../../config/nvim/plugin/lsp.lua;
        }

        # "completion engine for nvim"
        {
          plugin = nvim-cmp;
          config = toLuaFile ../../config/nvim/plugin/cmp.lua;
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
          config = toLuaFile ../../config/nvim/plugin/telescope.lua;
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
          config = toLuaFile ../../config/nvim/plugin/tmux_nav.lua;
        }

        {
          plugin = undotree;
        }

        vim-startuptime

        {
          plugin = quarto-nvim;
          config = toLua "require('quarto').setup{}";
        }
        {
          plugin = otter-nvim;
          config = toLua "local otter = require'otter'";
        }

      ];

      extraLuaConfig = ''
      
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
  };
}
