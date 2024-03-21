return {
	"RRethy/vim-illuminate",
	enabled = true,
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		providers = {
			"lsp",
			"treesitter",
		},
	},
	config = function(_, opts)
		require("illuminate").configure(opts)

		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "VisualNOS" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "VisualNOS" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "VisualNOS" })

		-- Disable illuminate when in visual mode to avoid visual conflicts with selected text
		local visual_event_group = vim.api.nvim_create_augroup("visual_event", { clear = true })

		-- regex pattern matching either of v (visual mode), V (line-wise), or ctrl-v (block-wise).
		vim.api.nvim_create_autocmd("ModeChanged", {
			group = visual_event_group,
			pattern = { "*:[v\x16]*" },
			callback = function()
				vim.cmd("IlluminatePause")
			end,
		})

		vim.api.nvim_create_autocmd("ModeChanged", {
			group = visual_event_group,
			pattern = { "[vV\x16]*:*" },
			callback = function()
				vim.cmd("IlluminateResume")
			end,
		})
	end,
}
