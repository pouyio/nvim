return {
	"esmuellert/codediff.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	cmd = "CodeDiff",
	keys = {
		{ "<leader>dd", "<cmd>CodeDiff<cr>", desc = "Code diff" },
	},
	opts = {
		explorer = {
			position = "right",
			width = 50,
			view_mode = "tree",
		},
		keymaps = {
			view = {
				next_file = "<S-Down>",
				prev_file = "<S-Up>",
			},
		},
	},
}
