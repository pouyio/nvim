vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
require("nvim-treesitter").setup()
require("nvim-treesitter").install({
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
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.treesitter.language.register("markdown", { "mdx" })

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
	desc = "Try to enable tree-sitter syntax highlighting",
	pattern = "*",
	callback = function()
		pcall(function()
			vim.treesitter.start()
		end)
	end,
})