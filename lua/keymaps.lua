local f = require("plugins.common.utils")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jj", "<Esc>")

-- relative jumps add entry to jumplist
vim.keymap.set("n", "k", [[(v:count > 1 ? "m'" . v:count : "") . 'gk']], { expr = true })
vim.keymap.set("n", "j", [[(v:count > 1 ? "m'" . v:count : "") . 'gj']], { expr = true })

-- select all
vim.keymap.set("n", f.isMac() and "<D-a>" or "<C-a>", "ggVG", { desc = "Select all" })

-- move half screen up/down
vim.keymap.set({ "n", "v" }, "<A-u>", "<C-u>")
vim.keymap.set({ "n", "v" }, "<A-d>", "<C-d>")

-- buffers
vim.keymap.set("n", "<leader><leader>", ":b#<CR>", { desc = "Toggle last buffer", silent = true })
vim.keymap.set("n", "<leader>w", f.closeBuffer, { noremap = true, silent = true, desc = "Close buffer" })

-- split
vim.keymap.set("n", "<leader>s", ":vs <CR>", { desc = "Split to right" })

-- panes
vim.keymap.set("n", "<Right>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "<Left>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<Down>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<Up>", "<C-w>k", { noremap = true })

-- windows resize
vim.keymap.set("n", "<leader>rk", ":horizontal resize +10<CR>", { desc = "vertical resize +10" })
vim.keymap.set("n", "<leader>rj", ":horizontal resize -10<CR>", { desc = "vertical resize -10" })
vim.keymap.set("n", "<leader>rl", ":vertical resize +10<CR>", { desc = "horizontal resize +10" })
vim.keymap.set("n", "<leader>rh", ":vertical resize -10<CR>", { desc = "horizontal resize -10" })

-- move selected line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "move line up" })

-- duplicate line
vim.keymap.set("n", "<S-A-Down>", ":t.<CR>", { desc = "Duplicate line down" })
vim.keymap.set("n", "<S-A-Up>", ":<C-u>.,.t-1<CR>", { desc = "Duplicate line up" })
vim.keymap.set("v", "<S-A-Down>", "yPgv", { desc = "Duplicate selected lines down" })
vim.keymap.set("v", "<S-A-Up>", "y'>pgv", { desc = "Duplicate selected lines up" })

-- delete full word
vim.keymap.set({ "i", "c" }, f.isMac() and "<A-BS>" or "<C-H>", function()
	vim.api.nvim_input("<C-w>")
end, { noremap = true })
vim.keymap.set("i", f.isMac() and "<A-Del>" or "<C-Del>", "<C-o>dw", { noremap = true })
vim.keymap.set("c", f.isMac() and "<A-Del>" or "<C-Del>", "<S-Right><C-W>", { noremap = true })

-- go back/forth
vim.keymap.set("n", "<A-->", "<C-o>", { desc = "go back" })
vim.keymap.set("n", f.isMac() and "<A-S-->" or "<A-_>", "<C-i>", { desc = "go forth" })

-- next/prev word
vim.keymap.set({ "n", "i", "v", "c", "o" }, f.isMac() and "<A-Right>" or "<C-Right>", "<S-Right>", { noremap = true })
vim.keymap.set({ "n", "i", "v", "c", "o" }, f.isMac() and "<A-Left>" or "<C-Left>", "<S-Left>", { noremap = true })

-- start/end line
vim.keymap.set({ "n", "v", "o" }, f.isMac() and "<D-Left>" or "<Home>", "^")
vim.keymap.set("i", f.isMac() and "<D-Left>" or "<Home>", "<C-o>^")
vim.keymap.set("c", f.isMac() and "<D-Left>" or "<Home>", "<C-b>")
vim.keymap.set({ "n", "o" }, f.isMac() and "<D-Right>" or "<End>", "$")
vim.keymap.set("v", f.isMac() and "<D-Right>" or "<End>", "g_") -- move to last non-blank character
vim.keymap.set("c", f.isMac() and "<D-Right>" or "<End>", "<C-e>")
vim.keymap.set("i", f.isMac() and "<D-Right>" or "<End>", "<C-o>$")

-- save file, update to only save to this if there are changes
vim.keymap.set("n", f.isMac() and "<D-s>" or "<C-s>", ":update<CR>")
vim.keymap.set({ "i", "v" }, f.isMac() and "<D-s>" or "<C-s>", "<Esc>:update<CR>")

-- redo
vim.keymap.set("n", "<S-u>", "<C-r>")

-- search for selected text
vim.keymap.set("v", "/", [[y/\V<C-R>=escape(@",'/\\')<CR><CR>]], { noremap = true })
vim.keymap.set("v", "?", [[y/\V<C-R>=escape(@",'/\\')<CR><CR>]], { noremap = true })

-- Only hit by accident
vim.keymap.set("n", "q:", "<Nop>")

-- Comments
vim.keymap.set("n", f.isMac() and "<D-u>" or "<C-u>", "gcc", { remap = true })
vim.keymap.set("v", f.isMac() and "<D-u>" or "<C-u>", "gcgv", { remap = true })
vim.keymap.set("i", f.isMac() and "<D-u>" or "<C-u>", "<ESC>gcci", { remap = true })

-- Navigate in quickfix list items
vim.keymap.set("n", f.isMac() and "<D-down>" or "<C-down>", ":cnext<CR>")
vim.keymap.set("n", f.isMac() and "<D-up>" or "<C-up>", ":cprevious<CR>")

-- Indent in visual mode using tab
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- disable copy when pasting in visual
vim.keymap.set("v", "p", '"_dP')

vim.keymap.set("i", "<S-Tab>", "<BS>")
