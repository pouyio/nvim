local f = require("common.utils")

vim.pack.add({
	"https://github.com/sustech-data/wildfire.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
})
require("wildfire").setup({
	keymaps = {
		init_selection = "<CR>",
		node_incremental = "<CR>",
		node_decremental = f.isMac() and "<S-CR>" or "⊘",
	},
})