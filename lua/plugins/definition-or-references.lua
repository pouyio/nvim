return {
	"KostkaBrukowa/definition-or-references.nvim",
	config = function()
		require("definition-or-references").setup({
			on_references_result = require("telescope.builtin").lsp_references,
		})
		vim.keymap.set("n", "gd", require("definition-or-references").definition_or_references, { silent = true })
	end,
}
