-- https://medium.com/@nikmas_dev/vscode-neovim-setup-keyboard-centric-powerful-reliable-clean-and-aesthetic-development-582d34297985

require("options")
vim.keymap.set("n", "<Space>", "", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<s-l>", function()
	require("vscode").call("editor.action.marker.next")
end)
vim.keymap.set("n", "<s-h>", function()
	require("vscode").call("editor.action.marker.prev")
end)

vim.keymap.set("n", "gr", function()
	require("vscode").call("editor.action.referenceSearch.trigger")
end)
vim.keymap.set("n", "gi", function()
	require("vscode").call("editor.action.goToImplementation")
end)

-- expand
vim.keymap.set({ "n", "v" }, "<CR>", function()
	require("vscode").call("editor.action.smartSelect.expand")
end, { noremap = true })

vim.keymap.set("n", "<leader>w", function()
	require("vscode").call("workbench.action.closeActiveEditor")
end, { noremap = true })

-- harpoon
vim.keymap.set({ "n", "v" }, "<leader>a", function()
	require("vscode").action("vscode-harpoon.addEditor")
end)
vim.keymap.set({ "n", "v" }, "<leader>tt", function()
	require("vscode").action("vscode-harpoon.editEditors")
end)
vim.keymap.set({ "n", "v" }, "<leader>h", function()
	require("vscode").action("vscode-harpoon.gotoEditor1")
end)
vim.keymap.set({ "n", "v" }, "<leader>j", function()
	require("vscode").action("vscode-harpoon.gotoEditor2")
end)
vim.keymap.set({ "n", "v" }, "<leader>k", function()
	require("vscode").action("vscode-harpoon.gotoEditor3")
end)
vim.keymap.set({ "n", "v" }, "<leader>l", function()
	require("vscode").action("vscode-harpoon.gotoEditor4")
end)

vim.keymap.set("n", "<", function()
	require("vscode").action("workbench.action.moveEditorLeftInGroup")
end)
vim.keymap.set("n", ">", function()
	require("vscode").action("workbench.action.moveEditorRightInGroup")
end)

vim.keymap.set("n", "<leader>rn", function()
	require("vscode").action("editor.action.rename")
end)

vim.keymap.set("n", "<leader>gi", function()
	require("vscode").action("editor.action.dirtydiff.next")
end)

vim.keymap.set("n", "<leader>gu", function()
	require("vscode").action("git.revertSelectedRanges")
end)

vim.keymap.set("n", "<S-Right>", function()
	require("vscode").action("workbench.action.nextEditor")
end)
vim.keymap.set("n", "<S-Left>", function()
	require("vscode").action("workbench.action.previousEditor")
end)

-- Indent in visual mode using tab
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

vim.keymap.set("n", "<esc>", ":nohlsearch<CR>")

-- redo
vim.keymap.set("n", "<S-u>", function()
	require("vscode").call("redo")
end)

-- code actions
vim.keymap.set("n", "<leader>.", function()
	require("vscode").call("editor.action.quickFix")
end)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			vim.keymap.set("v", "(", "<plug>(nvim-surround-visual)(lvi(", { desc = "Surround with brackets ()" })
			vim.keymap.set("v", "[", "<Plug>(nvim-surround-visual)[lvi[", { desc = "Surround with square brackets []" })
			vim.keymap.set("v", "{", "<Plug>(nvim-surround-visual){lvi{", { desc = "Surround with curly brackets {}" })
			vim.keymap.set("v", '"', '<Plug>(nvim-surround-visual)"lvi"', { desc = 'Surround with curly brackets ""' })
			vim.keymap.set("v", "`", "<Plug>(nvim-surround-visual)`lvi`", { desc = "Surround with curly brackets ``" })
			vim.keymap.set(
				"v",
				"<",
				"<Plug>(nvim-surround-visual)<lvi>",
				{ desc = "Surround with less/greater than <>" }
			)
			-- surround selected text with input
			vim.keymap.set(
				"v",
				"t",
				"<plug>(nvim-surround-visual)t",
				{ desc = "Surround with anything from input, html tags" }
			)
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
	},
})
