-- in WSL nvim > 0.11.0 breaks treesitter main, check after 0.11.5
-- also takes too long to quit
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"bash",
			"css",
			"go",
			"graphql",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"json5",
			"lua",
			"markdown",
			"regex",
			"scss",
			"sql",
			"terraform",
			"toml",
			"tsx",
			"typescript",
			"vue",
			"yaml",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter").setup()
		require("nvim-treesitter").install(opts.ensure_installed)

		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		vim.treesitter.language.register("markdown", { "mdx" })

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
			desc = "Try to enable tree-sitter syntax highlighting",
			pattern = "*", -- run on *all* filetypes
			callback = function()
				pcall(function()
					vim.treesitter.start()
				end)
			end,
		})
	end,
}
