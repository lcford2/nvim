local opts = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = " ",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
  expr = false, -- use `expr` when creating keymaps
}

local harpoon = require("harpoon")

local mappings = {
  -- telescope mappings
  f = {
    name = "Find",
    f =  { "<cmd>Telescope find_files<cr>", "Find File" },
    t =  { "<cmd>Telescope live_grep<cr>", "Grep" },
    r =  { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    k =  { "<cmd>Telescope keymaps<cr>", "Find Keymaps" },
    h =  { "<cmd>Telescope help_tags<cr>", "Find Help Tags" },
    c =  { "<cmd>Telescope colorsheme<cr>", "Find Colorscheme" },
    d =  { "<cmd>Telescope diagnostics<cr>", "Find Diagnostics" },
    b =  { "<cmd>Telescope buffers<cr>", "Find Buffers" },
    g = {
      name = "Git",
      f =  { "<cmd>Telescope git_files<cr>", "Files" },
      c = { "<cmd>Telescope git_commits<cr>", "Commits" },
      b = { "<cmd>Telescope git_branches<cr>", "Branches" },
    }
  },
  -- go to config
  g = {
    name = "GoTo",
    d = { function () vim.lsp.buf.definition () end, "Definition" },
    D = { function () vim.lsp.buf.declaration () end, "Delcaration" },
    r = { function () vim.lsp.buf.references () end, "References" },
    i = { function () vim.lsp.buf.implementation () end, "Implementation" },
    t = { function () vim.lsp.buf.type_definition () end, "Type Definition" },
  },
  -- lsp config
  l = {
    name = "LSP",
    w = {
      name = "Workspace",
      a = { function () vim.lsp.buf.add_workspace_folder () end, "Add Folder" },
      r = { function () vim.lsp.buf.remove_workspace_folder () end, "Remove Folder" },
      l = { function () vim.lsp.buf.list_workspace_folders () end, "List Folders" },
    },
    r = { function () vim.lsp.buf.rename() end, "Rename" },
    a = { function () vim.lsp.buf.code_action() end, "Code Action" },
    f = { function () vim.lsp.buf.format () end, "Format Buffer" },
    n = { function () vim.lsp.buf.goto_next() end, "Next Problem" },
    p = { function () vim.lsp.buf.goto_prev() end, "Previous Problem" },
    h = { function () vim.lsp.buf.hover() end, "Function Help" },
  },
  -- git configs
  g = {
    name = "Git",
    s = { vim.cmd.Git, "Status" },
    p = { "<cmd>Git push<cr>", "Push" },
    P = { "<cmd>Git pull<cr>", "Pull" },
    c = { "<cmd>Git checkout<cr>", "Checkout" },
  },
  -- harpoon config
  h = {
    name = "Harpoon",
    a = { function () harpoon.mark.add_file () end, "Add file" },
    m = { function () harpoon.ui.toggle_quick_menu () end, "Menu" },
    h = { function () harpoon.ui.nav_file(1) end, "File 1" },
    j = { function () harpoon.ui.nav_file(2) end, "File 2" },
    k = { function () harpoon.ui.nav_file(3) end, "File 3" },
    l = { function () harpoon.ui.nav_file(4) end, "File 4" },
  },
  -- open configs
  o = {
    name = "Open",
    u = { vim.cmd.UndotreeToggle, "UndoTree" },
    d = { vim.cmd.Ex, "Explorer" },
    t = { OpenTerminal, "Terminal" },
  },
  -- window configs
  w = {
    name = "Window",
    W = { function() SetWindowWidthAsRatio(0.8) end, "Set window to 80% of total width" },
    V = { function() SetWindowHeightAsRatio(0.8) end, "Set window to 80% of total height" },
  },
}

local wk = require("which-key")
wk.register(mappings, opts)
