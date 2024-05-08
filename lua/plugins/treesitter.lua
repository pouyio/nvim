return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local f = require("plugins.common.utils")
		local treesitter = require("nvim-treesitter.configs")

		-- set .mdx files as markdown
		local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
		ft_to_parser.mdx = "markdown"

		treesitter.setup({

			highlight = {
				enable = true,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			auto_install = true,
			indent = {
				enable = true,
			},
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
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = f.isMac() and "<D-A-Right>" or "<C-A-Right>",
					node_incremental = f.isMac() and "<D-A-Right>" or "<C-A-Right>",
					node_decremental = f.isMac() and "<D-A-Left>" or "<C-A-Left>",
				},
			},
		})
	end,
}
