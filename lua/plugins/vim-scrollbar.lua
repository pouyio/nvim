return {
	"petertriho/nvim-scrollbar",
	dependencies = {
		{
			"kevinhwang91/nvim-hlslens",
			config = function()
				require("scrollbar.handlers.search").setup({
					override_lens = function()
						return ""
					end,
				})
			end,
		},
	},
	opts = {
		handlers = {
			handle = false,
		},
		marks = {
			Error = { color = "#c53b53" },
			Warn = { color = "#ffc777" },
			Info = { color = "#0db9d7" },
			Hint = { color = "#4fd6be" },
			Misc = { color = "#c75ae8" },
		},
		excluded_filetypes = {
			"neo-tree",
			"neo-tree-popup",
		},
	},
}
