-- File manager specific binding
local function setup_file_manager_binding()
  local filetypes = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" }
  for _, ft in ipairs(filetypes) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft,
      callback = function()
        vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { noremap = true, silent = true, desc = "Add file", buffer = true })
      end,
    })
  end
end

setup_file_manager_binding()
