vim.g.opencode_opts = {}

vim.o.autoread = true

local status_ok, opencode = pcall(require, "opencode")
if not status_ok then
  return
end

vim.keymap.set({ "n", "x" }, "<leader>aa", function()
  opencode.ask("@this: ", { submit = true })
end, { desc = "Ask opencode" })

vim.keymap.set({ "n", "x" }, "<leader>as", function()
  opencode.select()
end, { desc = "Select opencode action" })

vim.keymap.set({ "n", "t" }, "<leader>at", function()
  opencode.toggle()
end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "<leader>ar", function()
  return opencode.operator("@this ")
end, { desc = "Send range to opencode", expr = true })

vim.keymap.set("n", "<leader>al", function()
  return opencode.operator("@this ") .. "_"
end, { desc = "Send line to opencode", expr = true })

vim.keymap.set("n", "<leader>au", function()
  opencode.command("session.half.page.up")
end, { desc = "Scroll opencode up" })

vim.keymap.set("n", "<leader>ad", function()
  opencode.command("session.half.page.down")
end, { desc = "Scroll opencode down" })
