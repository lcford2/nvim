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
