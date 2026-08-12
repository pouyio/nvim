vim.pack.add({ "https://github.com/kylechui/nvim-surround" })
vim.keymap.set("v", "(", "<plug>(nvim-surround-visual)(lvi(", { desc = "Surround with brackets ()" })
vim.keymap.set("v", "[", "<Plug>(nvim-surround-visual)[lvi[", { desc = "Surround with square brackets []" })
vim.keymap.set("v", "{", "<Plug>(nvim-surround-visual){lvi{", { desc = "Surround with curly brackets {}" })
vim.keymap.set("v", '"', '<Plug>(nvim-surround-visual)"lvi"', { desc = 'Surround with curly brackets ""' })
vim.keymap.set("v", "`", "<Plug>(nvim-surround-visual)`lvi`", { desc = "Surround with curly brackets ``" })
vim.keymap.set("v", "<", "<Plug>(nvim-surround-visual)<lvi>", { desc = "Surround with less/greater than <>" })
vim.keymap.set("v", "t", "<plug>(nvim-surround-visual)t", { desc = "Surround with anything from input, html tags" })
require("nvim-surround").setup({
	surrounds = {
		["("] = { add = { "(", ")" } },
		["{"] = { add = { "{", "}" } },
		["<"] = { add = { "<", ">" } },
		["["] = { add = { "[", "]" } },
	},
})