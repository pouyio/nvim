return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		-- unding requires several actions, maybe it can be improved
		vim.keymap.set("v", "(", "<plug>(nvim-surround-visual)(lvi(", { desc = "toggle last buffer" })
		vim.keymap.set("v", "[", "<Plug>(nvim-surround-visual)[lvi[", { desc = "Toggle last buffer" })
		vim.keymap.set("v", "{", "<Plug>(nvim-surround-visual){lvi{", { desc = "Toggle last buffer" })
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
