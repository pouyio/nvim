local f = require("plugins.common.utils")

return {
	{
		-- windows with wsl does not listen for background change
		-- last message in: https://chatgpt.com/share/681f1213-6938-8013-adcb-802845e8bb32
		"f-person/auto-dark-mode.nvim",
		enabled = not f.isMac(),
		opts = {},
	},
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				styles = {
					functions = "bold",
				},
			})
			vim.cmd.colorscheme("onedark_vivid")
			vim.api.nvim_create_autocmd("OptionSet", {
				pattern = "background",
				callback = function(_)
					vim.cmd.colorscheme(vim.o.background == "light" and "onelight" or "onedark_vivid")

					f.HighlightGroups.executeAll()
				end,
			})
		end,
	},
}
