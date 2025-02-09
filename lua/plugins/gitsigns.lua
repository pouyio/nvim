return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 300,
			},
			current_line_blame_formatter = "        <author>, <author_time:%R> - <summary>",
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				vim.keymap.set("n", "<A-h>", function()
					gitsigns.nav_hunk("prev")
				end, { buffer = bufnr })
				vim.keymap.set("n", "<A-l>", function()
					gitsigns.nav_hunk("next")
				end, { buffer = bufnr })
			end,
		}
		require("gitsigns").setup(opts)
		require("scrollbar.handlers.gitsigns").setup()
	end,
}
