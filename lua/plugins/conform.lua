local f = require("plugins.common.formatters")

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({

			formatters_by_ft = f.conform_formatters(),
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout = 500,
			},
		})
	end,
}
