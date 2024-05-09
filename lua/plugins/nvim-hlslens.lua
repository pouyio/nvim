return {
	"kevinhwang91/nvim-hlslens",
	config = function()
		local kopts = { noremap = true, silent = true }
		vim.api.nvim_set_keymap(
			"n",
			"n",
			[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)
		vim.api.nvim_set_keymap(
			"n",
			"N",
			[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			kopts
		)
		vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
		require("scrollbar.handlers.search").setup({
			calm_down = true, -- hide highlight when moving cursor out of one
			override_lens = function()
				-- dont show any text on the lense
			end,
		})
	end,
}
