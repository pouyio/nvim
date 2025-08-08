local f = require("plugins.common.utils")
return {
	"pouyio/wildfire.nvim",
	event = "VeryLazy",
	opts = {
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = f.isMac() and "<S-CR>" or "⊘", -- strange unicode mapped in windows because it cant understand shift+enter
		},
	},
}
