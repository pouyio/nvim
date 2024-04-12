local f = require("plugins.common.utils")

return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring", -- for commenting properly in tsx
	},
	config = function()
		local comment = require("Comment")
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})
		-- enable comment
		comment.setup({
			-- for commenting tsx, jsx, svelte, html files
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			toggler = {
				line = f.isMac() and "<D-u>" or "<C-u>",
			},
			opleader = {
				line = f.isMac() and "<D-u>" or "<C-u>",
			},
		})
	end,
}
