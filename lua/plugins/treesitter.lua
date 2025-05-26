return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "master",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		vim.treesitter.language.register("markdown", { "mdx" })

		treesitter.setup({
			highlight = {
				enable = true,
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
			-- incremental_selection = {
			-- 	enable = true,
			-- 	keymaps = {
			-- 		init_selection = "<CR>",
			-- 		node_incremental = "<CR>",
			-- 		node_decremental = f.isMac() and "<S-CR>" or "⊘", -- strange unicode mapped in windows because it cant understand shift+enter
			-- 	},
			-- },
		})
	end,
}
