return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				options = {
					cursorline = true,
				},
				styles = {
					functions = "bold",
				},
			})
			vim.cmd.colorscheme("onedark_vivid")
			vim.api.nvim_create_autocmd("OptionSet", {
				pattern = "background",
				callback = function(_)
					vim.cmd.colorscheme(vim.o.background == "light" and "onelight" or "onedark_vivid")
					vim.api.nvim_exec_autocmds("ColorScheme", {}) -- Trigger the ColorScheme autocommand used in the multicursor plugin
				end,
			})
		end,
	},
}
