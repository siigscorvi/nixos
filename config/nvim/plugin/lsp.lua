local on_attach = function(_, bufnr)
  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('<leader>r', vim.lsp.buf.rename)
  bufmap('<leader>a', vim.lsp.buf.code_action)

  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)

  bufmap('gr', require('telescope.builtin').lsp_references)
  --- bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
  --- bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  bufmap('K', vim.lsp.buf.hover)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig").nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake "~/.dotfiles/").nixosConfigurations.genesis.options',
        },
      --   home_manager = {
      --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").homeConfigurations.CONFIGNAME.options',
      --   },
      },
    },
  },
})

require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
	root_dir = function()
        return vim.loop.cwd()
    end,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}
--- require'lspconfig'.cmake.setup{}
--- require'lspconfig'.ccls.setup{} TODO https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html

local function combined_attach()
  on_attach()
  require("ltex_extra").setup({
    load_langs = { 'de-DE', 'en-US' }, -- Which languages do you want to load on init.
  })
end
require'lspconfig'.ltex.setup{
    on_attach = combined_attach,
    capabilities = capabilities,
  settings = {
    ltex = {
      language = { "de-DE","en-US", },
    },
  },
}

-- this needs to cleaned up, automated and synchronized
--- require'lspconfig'.markdown_oxide.setup{}
require'lspconfig'.marksman.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
--- require'lspconfig'.gopls.setup{}
--- require'lspconfig'.golangci_lint_ls.setup{}
--- require'lspconfig'.superhtml.setup{}
--- require'lspconfig'.asm_lsp.setup{}
--- require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.bashls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
--- require'lspconfig'.dockerls.setup{}
require'lspconfig'.taplo.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
require'lspconfig'.yamlls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}


