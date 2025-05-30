local f = require("plugins.common.utils")

return {
	"petertriho/nvim-scrollbar",
	dependencies = {
		{
			"kevinhwang91/nvim-hlslens",
			event = "VeryLazy",
			config = function()
				require("scrollbar.handlers.search").setup({
					override_lens = function()
						return ""
					end,
				})
			end,
		},
		"lewis6991/gitsigns.nvim",
	},
	opts = {
		handlers = {
			handle = false,
		},
		marks = {
			Error = { text = { f.diagnosticIcons.ERROR, f.diagnosticIcons.ERROR } },
			Warn = { text = { f.diagnosticIcons.WARN, f.diagnosticIcons.WARN } },
			Info = { text = { f.diagnosticIcons.INFO, f.diagnosticIcons.INFO } },
			Hint = { text = { f.diagnosticIcons.HINT, f.diagnosticIcons.HINT } },
			GitDelete = { text = "" },
		},
		excluded_filetypes = {
			"neo-tree",
			"neo-tree-popup",
		},
	},
}
