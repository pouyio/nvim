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
			Error = { text = { " ", " " } },
			Warn = { text = { " ", " " } },
			Info = { text = { " ", " " } },
			Hint = { text = { "󰌵", "󰌵" } },
			Misc = {},
		},
		excluded_filetypes = {
			"neo-tree",
			"neo-tree-popup",
		},
	},
}
