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

		vim.api.nvim_create_user_command("DiffThis", function()
			gitsigns.diffthis("~")
			vim.defer_fn(function()
				vim.api.nvim_command("wincmd h")
			end, 50)
		end, { desc = "Open git diff file" })

		gitsigns.setup(opts)
		require("scrollbar.handlers.gitsigns").setup()
	end,
}
