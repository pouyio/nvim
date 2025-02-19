return {
	"KostkaBrukowa/definition-or-references.nvim",
	config = function()
		require("definition-or-references").setup({
			on_references_result = function()
				Snacks.picker.lsp_references()
			end,
		})
		vim.keymap.set("n", "gd", require("definition-or-references").definition_or_references, { silent = true })
		vim.keymap.set(
			"n",
			"gs",
			':vs<CR> <Cmd>lua require("definition-or-references").definition_or_references()<CR>',
			{ silent = true }
		)
		vim.keymap.set(
			"n",
			"gt",
			'<cmd>tab split | lua require("definition-or-references").definition_or_references()<CR>',
			{ silent = true }
		)
	end,
}
