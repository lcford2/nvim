if vim.fn.exists("*CalcNvimSetup") == 1 then
	local calc = require("calc_nvim")
	calc.setup({
	  float_format="0.5f",
	  log_level="DEBUG",
	})
	vim.keymap.set("v", "<C-c>", calc.calculate, {})
	vim.keymap.set("v", "<C-f>", calc.format_number, {})
end
