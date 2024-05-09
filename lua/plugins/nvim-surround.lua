return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		vim.keymap.set("v", "(", "<plug>(nvim-surround-visual)(lvi(", { desc = "Surround with brackets ()" })
		vim.keymap.set("v", "[", "<Plug>(nvim-surround-visual)[lvi[", { desc = "Surround with square brackets []" })
		vim.keymap.set("v", "{", "<Plug>(nvim-surround-visual){lvi{", { desc = "Surround with curly brackets {}" })
		vim.keymap.set("v", '"', '<Plug>(nvim-surround-visual)"lvi"', { desc = 'Surround with curly brackets ""' })
		vim.keymap.set("v", "`", "<Plug>(nvim-surround-visual)`lvi`", { desc = "Surround with curly brackets ``" })
		require("nvim-surround").setup({
			surrounds = {
				["("] = {
					add = { "(", ")" },
				},
				["{"] = {
					add = { "{", "}" },
				},
				["<"] = {
					add = { "<", ">" },
				},
				["["] = {
					add = { "[", "]" },
				},
			},
		})
	end,
}
