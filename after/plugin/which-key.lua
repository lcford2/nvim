local harpoon = require("harpoon")
-- harpoon telescope function
local function toggle_telescope(harpoon_files)
    local conf = require("telescope.config").values
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

local tman = require("tman")

local opts = {
  mode = "n", -- NORMAL mode
  prefix = " ",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
  expr = false, -- use `expr` when creating keymaps
}

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
    g = {
      name = "Git",
      f =  { "<cmd>Telescope git_files<cr>", "Files" },
      c = { "<cmd>Telescope git_commits<cr>", "Commits" },
      b = { "<cmd>Telescope git_branches<cr>", "Branches" },
    }
  },
  b = {
    name = "Buffers",
    l = { "<cmd>bprev<cr>", "Last Buffer" },
    n = { "<cmd>bnext<cr>", "Last Buffer" },
    b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
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
  h = {
    name = "Harpoon",
    a = { function () harpoon:list():append() end, "Add file" },
    m = { function () toggle_telescope(harpoon:list()) end, "Menu" },
    -- m = { function() require("harpoon.ui"):toggle_quick_menu(require("harpoon"):list()) end, "Menu" },
    J = { function () harpoon:list():next() end, "Next File" },
    K = { function () harpoon:list():prev() end, "Previous File" },
    h = { function () harpoon:list():select(1) end , "File 1" },
    j = { function () harpoon:list():select(2) end , "File 2" },
    k = { function () harpoon:list():select(3) end , "File 3" },
    l = { function () harpoon:list():select(4) end , "File 4" },
    e = { function () harpoon:list():clear() end, "Clear Marks" },
  },
  -- open configs
  o = {
    name = "Open",
    u = { vim.cmd.UndotreeToggle, "UndoTree" },
    -- Use netrw
    -- d = { vim.cmd.Ex, "Explorer" },
    -- Use triptych
    d = { "<cmd>Triptych<cr>" , "File Explore" },
    -- t = { OpenTerminal, "Terminal" },
    t = { function () tman.toggleLast({insert = true}) end, "Terminal" },
    r = { tman.toggleRight, "Terminal Right" },
  },
  t = {
    name = "Terminal",
    t = { function () tman.toggleLast({insert = true}) end, "Terminal" },
    r = { tman.toggleRight, "Terminal Right" },
    c = { ":TmanCmd<CR>", "Send Terminal Command"},
    l = { ":TmanCmdLast<CR>", "Send Last Terminal Command"},
  },
  -- window configs
  w = {
    name = "Window",
    W = { function() SetWindowWidthAsRatio(0.8) end, "Set window to 80% of total width" },
    V = { function() SetWindowHeightAsRatio(0.8) end, "Set window to 80% of total height" },
  },
  -- neorg for notes
  n = {
    name = "Notes",
    n = { "<cmd>Telekasten new_note<cr>", "New Note" },
    f = { "<cmd>Telekasten find_notes<cr>", "Find Note" },
    t = { "<cmd>Telekasten show_tags<cr>", "Show Tags" },
    s = { "<cmd>Telekasten search_notes<cr>", "Search Notes" },
    d = { "<cmd>Telekasten find_daily_notes<cr>", "Find Daily Note" },
    D = { "<cmd>Telekasten goto_today<cr>", "Goto Today's Note" },
    c = { "<cmd>Telekasten show_calendar<cr>", "Calendar" },
    l = { "<cmd>Telekasten insert_link<cr>", "Insert Link" },
    L = { "<cmd>Telekasten show_backlinks<cr>", "Show Links to Note" },
    T = { "<cmd>Telekasten toggle_todo<cr>", "Toggle Todo" },
    w = { "<cmd>Telekasten find_weekly_notes<cr>", "Find Weekly Note" },
    W = { "<cmd>Telekasten goto_thisweek<cr>", "Goto This Week's Note" },
  },
}

local wk = require("which-key")
wk.register(mappings, opts)
