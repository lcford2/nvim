local lsp_zero = require('lsp-zero')

-- lsp config moved to which key config
-- lsp_zero.on_attach(function(client, bufnr)
--   local opts = { buffer = bufnr, remap = false }
--
--   -- TODO: can I use telescope here?
--   vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--   vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--   vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
--   vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
--   vim.keymap.set("n", "<leader>ljd", function() vim.diagnostic.goto_next() end, opts)
--   vim.keymap.set("n", "<leader>lkd", function() vim.diagnostic.goto_prev() end, opts)
--   vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
--   vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
--   vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
--   vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--   vim.keymap.set("n", "<leader>F", function() vim.lsp.buf.format() end, opts)
-- end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer', 'bashls', 'clangd', 'cmake', 'dockerls',
    'docker_compose_language_service', 'pyright', 'lua_ls'
  },
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})
