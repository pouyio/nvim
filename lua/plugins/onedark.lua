return {
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "darker",
				code_style = {
					functions = "bold",
				},
				colors = {
					bg3 = "#4c5263",
				},
			})
			-- vim.cmd.colorscheme("onedark")
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		config = function()
			require("onedarkpro").setup({
				colors = {
					bg = "#1f232d",
				},
				styles = {
					functions = "bold",
				},
			})
			vim.cmd.colorscheme("onedark_vivid")
		end,
	},
}
