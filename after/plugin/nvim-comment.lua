local status_ok, nvim_comment = pcall(require, 'nvim_comment')
if not status_ok then
  return
end
require('nvim_comment').setup({
  comment_empty = false,
  create_mappings = false,
})
vim.keymap.set({"n","v"}, ";", ":CommentToggle<CR>")
