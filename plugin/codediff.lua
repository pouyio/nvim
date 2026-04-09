vim.pack.add({
	"https://github.com/esmuellert/codediff.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
})
vim.keymap.set("n", "<leader>dd", "<cmd>CodeDiff<cr>", { desc = "Code diff" })
require("codediff").setup({
	explorer = { view_mode = "tree" },
	keymaps = {
		view = { next_file = "<S-Down>", prev_file = "<S-Up>" },
	},
})