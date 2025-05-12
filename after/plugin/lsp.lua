local lsp_zero = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
    'bashls',
    'clangd',
    'cmake',
    'dockerls',
    'docker_compose_language_service',
    'pyright',
    'lua_ls',
    'ruff',
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

-- Clangd config for ros stuff
local lspconfig = require("lspconfig")
local util      = require("lspconfig.util")

lspconfig.clangd.setup {
  -- define how to find project “root”
  root_dir = function(fname)
    -- walk up until you find a directory containing "build"
    local root_with_build = util.search_ancestors(fname, function(path)
      if vim.fn.isdirectory(path .. "/build") == 1 then
        return path
      end
    end)
    if root_with_build then
      return root_with_build
    end
    -- fallback: look for .git, or else just use cwd
    return util.root_pattern(".git")(fname)
        or vim.loop.cwd()
  end,

  -- 2) once the root is determined, tell clangd about your compile_commands.json
  on_new_config = function(new_config, new_root_dir)
    local build_dir = new_root_dir .. "/build"
    if vim.fn.isdirectory(build_dir) == 1 then
      -- insert the clangd flag to point at your compile_commands.json
      table.insert(new_config.cmd, "--compile-commands-dir=" .. build_dir)
    end
  end,

  -- 3) any other clangd-specific flags you like
  cmd = { "clangd", "--background-index", "--pch-storage=memory" },
}
