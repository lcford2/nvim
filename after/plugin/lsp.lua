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
})

-- Configure LSP servers using new vim.lsp.config API
local servers = {
  rust_analyzer = {
    cmd = { 'rust-analyzer' },
    root_markers = { 'Cargo.toml', '.git' },
  },
  bashls = {
    cmd = { 'bash-language-server', 'start' },
    root_markers = { '.git' },
  },
  cmake = {
    cmd = { 'cmake-language-server' },
    root_markers = { 'CMakeLists.txt', '.git' },
  },
  dockerls = {
    cmd = { 'docker-langserver', '--stdio' },
    root_markers = { 'Dockerfile', '.git' },
  },
  docker_compose_language_service = {
    cmd = { 'docker-compose-langserver', '--stdio' },
    root_markers = { 'docker-compose.yml', 'docker-compose.yaml', '.git' },
  },
  pyright = {
    cmd = { 'pyright-langserver', '--stdio' },
    root_markers = { 'pyproject.toml', 'setup.py', '.git' },
  },
  ruff = {
    cmd = { 'ruff', 'server' },
    root_markers = { 'pyproject.toml', 'setup.py', '.git' },
  },
  lua_ls = {
    cmd = { 'lua-language-server' },
    root_markers = { '.luarc.json', '.git' },
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
}

-- Set up all servers except clangd (which needs custom config)
for server, config in pairs(servers) do
  vim.lsp.config(server, config)
end

-- Custom clangd configuration for ROS
vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index', '--pch-storage=memory' },
  root_markers = { 'build', '.git' },

  -- Custom root_dir logic
  root_dir = function(fname)
    local util = require("lspconfig.util")

    -- Convert buffer number to file path if needed
    local filepath = fname
    if type(fname) == "number" then
      filepath = vim.api.nvim_buf_get_name(fname)
    end

    -- Handle empty path
    if filepath == "" then
      return vim.loop.cwd()
    end

    -- Walk up until you find a directory containing "build"
    local root_with_build = util.search_ancestors(filepath, function(path)
      if vim.fn.isdirectory(path .. "/build") == 1 then
        return path
      end
    end)
    if root_with_build then
      return root_with_build
    end

    -- Fallback: look for .git, or else just use cwd
    return util.root_pattern(".git")(filepath) or vim.loop.cwd()
  end,
  -- Tell clangd about compile_commands.json
  on_new_config = function(new_config, new_root_dir)
    local build_dir = new_root_dir .. "/build"
    if vim.fn.isdirectory(build_dir) == 1 then
      table.insert(new_config.cmd, "--compile-commands-dir=" .. build_dir)
    end
  end,
})

-- Enable all LSP servers
vim.lsp.enable({
  'rust_analyzer',
  'bashls',
  'clangd',
  'cmake',
  'dockerls',
  'docker_compose_language_service',
  'pyright',
  'lua_ls',
  'ruff',
})

-- CMP setup (unchanged)
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
