local status_ok, calc = pcall(require, "calc_nvim")

if not status_ok then
	return
end

calc.setup({
  float_format="0.5f",
  log_level="DEBUG",
})
vim.keymap.set("v", "<C-c>", calc.calculate, {})
vim.keymap.set("v", "<C-f>", calc.format_number, {})
