return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")
		local opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 300,
			},
			current_line_blame_formatter = "        <author>, <author_time:%R> - <summary>",
			signs = {
				delete = { text = "" },
				topdelete = { text = "" },
			},
			signs_staged = {
				delete = { text = "" },
				topdelete = { text = "" },
			},
			on_attach = function(bufnr)
				vim.keymap.set("n", "<A-h>", function()
					gitsigns.nav_hunk("prev")
				end, { buffer = bufnr })
				vim.keymap.set("n", "<A-l>", function()
					gitsigns.nav_hunk("next")
				end, { buffer = bufnr })
				vim.keymap.set("n", "<leader>gi", gitsigns.preview_hunk)
				vim.keymap.set("n", "<leader>gu", gitsigns.reset_hunk)
				vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk)
			end,
		}

		gitsigns.setup(opts)
		require("scrollbar.handlers.gitsigns").setup()
	end,
}
