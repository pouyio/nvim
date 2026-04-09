local f = require("common.utils")

vim.pack.add({ "https://github.com/f-person/auto-dark-mode.nvim" })
require("auto-dark-mode").setup({})

vim.pack.add({ "https://github.com/olimorris/onedarkpro.nvim" })
require("onedarkpro").setup({
	styles = {
		functions = "bold",
	},
	highlights = {
		LspReferenceText = { link = "CursorColumn", extend = true },
		NeoTreeCursorLine = { bg = "${cursorline}", bold = true },
		NeominimapCursorLine = { bg = "${gray}", bold = true },
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