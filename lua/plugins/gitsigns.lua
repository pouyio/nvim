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
		}
		require("gitsigns").setup(opts)
	end,
}
