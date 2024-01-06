-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: lazy.nvim
-- URL: https://github.com/folke/lazy.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
  return
end

-- Start setup
lazy.setup({
  spec = {
    -- Pretty stuff:
    -- panda color scheme
    {
      'markvincze/panda-vim',
    },
    {
      'rafi/awesome-vim-colorschemes',
    },
    {
      'sainnhe/everforest',
      lazy = false,    -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
    },
    {
      'navarasu/onedark.nvim',
    },
    -- Icons
    { 'kyazdani42/nvim-web-devicons', lazy = true },
    -- Dashboard (start screen)
    {
      'goolord/alpha-nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    -- File navigation
    {
      'theprimeagen/harpoon',
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.3',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- File explorer (tree)
    {
      'kyazdani42/nvim-tree.lua',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
    -- File explorer (popup)
    {
      'simonmclean/triptych.nvim',
      event = 'VeryLazy',
      dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'nvim-tree/nvim-web-devicons', -- optional
      }
    },

    -- Editor tools
    { 'mbbill/undotree' },
    { 'terrortylor/nvim-comment' },
    { 'nvim-treesitter/nvim-treesitter',      build = ':TSUpdate' },
    { 'nvim-treesitter/nvim-treesitter-context' },
    -- Git labels
    {
      'lewis6991/gitsigns.nvim',
      lazy = true,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('gitsigns').setup {}
      end
    },
    -- Statusline
    {
      'freddiehaddad/feline.nvim',
      dependencies = {
        'kyazdani42/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
      },
    },
    -- pydoctstring
    -- { 'heavenshell/vim-pydocstring' },
    -- doge documentation generator
    { 'kkoomen/vim-doge',                    build = ':call doge#install()' },
    -- vim context
    -- { 'wellle/context.vim' },
    -- indent blankline
    { 'lukas-reineke/indent-blankline.nvim', main = 'ibl',                  opts = {} },
    -- keybinding help
    { 
      'folke/which-key.nvim',
      event = "VeryLazy",
      init = function ()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        window = {
          border = "single",
        },
        layout = {
          align = "center"
        },
      }
    },

    -- Git Tools
    { 'tpope/vim-fugitive' },
    -- git gutter
    { 'airblade/vim-gitgutter' },
    { 'f-person/git-blame.nvim' },
    -- neovim tmux integration
    { 'christoomey/vim-tmux-navigator' },

    -- LSP Zero Setup
    { 'VonHeikemen/lsp-zero.nvim',           branch = 'v3.x' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
  },
})
