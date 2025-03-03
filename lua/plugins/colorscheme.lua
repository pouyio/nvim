return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it laods first
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
		end,
	},
}
