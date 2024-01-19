local calc = require("calc_nvim")

calc.setup({
  float_format="0.3",
  log_level="DEBUG",
})
vim.keymap.set("v", "<C-c>", calc.calculate, {})
