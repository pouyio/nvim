return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it laods first
		config = function()
			require("onedarkpro").setup({
				colors = {
					dark = {
						bg = "#1f232d",
					},
				},
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
