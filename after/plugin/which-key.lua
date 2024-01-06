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
    T =  { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy Find in File" },
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
    d = { vim.lsp.buf.definition , "Definition" },
    D = { vim.lsp.buf.declaration , "Delcaration" },
    i = { vim.lsp.buf.implementation , "Implementation" },
    t = { vim.lsp.buf.type_definition , "Type Definition" },
  },
  -- lsp config
  l = {
    name = "LSP",
    w = {
      name = "Workspace",
      a = { vim.lsp.buf.add_workspace_folder , "Add Folder" },
      r = { vim.lsp.buf.remove_workspace_folder , "Remove Folder" },
      l = { vim.lsp.buf.list_workspace_folders , "List Folders" },
    },
    r = { vim.lsp.buf.rename, "Rename" },
    a = { vim.lsp.buf.code_action, "Code Action" },
    f = { vim.lsp.buf.format , "Format Buffer" },
    n = { vim.lsp.buf.goto_next, "Next Problem" },
    p = { vim.lsp.buf.goto_prev, "Previous Problem" },
    h = { vim.lsp.buf.hover, "Function Help" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    R = { "<cmd>Telescope lsp_references<cr>", "References" },
  },
  -- git configs
  G = {
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
