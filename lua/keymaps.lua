local f = require("plugins.common.utils")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("t", f.isMac() and "<D-j>" or "<C-j>", "<C-\\><C-n>", { noremap = true })

-- visual movement
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- select all
vim.keymap.set("n", f.isMac() and "<D-a>" or "<C-a>", "ggVG", { desc = "Select all" })

-- move 9 lines up/down
vim.keymap.set({ "n", "v" }, "<A-u>", "<C-u>")
vim.keymap.set({ "n", "v" }, "<A-d>", "<C-d>")

-- buffers
vim.keymap.set("n", "<leader><leader>", ":b#<CR>", { desc = "Toggle last buffer" })
vim.keymap.set("t", "<leader><leader>", "<C-\\><C-n>:b#<CR>", { desc = "Toggle last buffer from terminal" })
vim.keymap.set("n", "<leader>w", f.closeBuffer, { noremap = true, silent = true, desc = "Close buffer" })

-- Switch buffers TODO subject to change for something more useful
vim.keymap.set("n", "<A-,>", ":bprevious<CR>")
vim.keymap.set("n", "<A-.>", ":bnext<CR>")

-- split
vim.keymap.set("n", "<leader>sl", ":vs -<CR>", { desc = "Split to right" })
vim.keymap.set("n", "<leader>sh", ":topleft vs -<CR>", { desc = "Split to left" })
vim.keymap.set("n", "<leader>sj", ":sp<CR><C-W>j", { desc = "Split to bottom", noremap = true, silent = true })

-- panes
vim.keymap.set("n", "<Right>", "<C-w>l", { noremap = true })
vim.keymap.set("n", "<Left>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<Down>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<Up>", "<C-w>k", { noremap = true })

-- windows resize
vim.keymap.set("n", "<leader>rk", ":horizontal resize +5<CR>", { desc = "vertical resize +5" })
vim.keymap.set("n", "<leader>rj", ":horizontal resize -5<CR>", { desc = "vertical resize -5" })
vim.keymap.set("n", "<leader>rl", ":vertical resize +5<CR>", { desc = "horizontal resize +5" })
vim.keymap.set("n", "<leader>rh", ":vertical resize -5<CR>", { desc = "horizontal resize -5" })

-- move selected line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move line up" })

-- delete full word
vim.keymap.set({ "i", "c" }, f.isMac() and "<A-BS>" or "<C-H>", function()
	vim.api.nvim_input("<C-w>")
end, { noremap = true })
vim.keymap.set("i", f.isMac() and "<A-Del>" or "<C-Del>", "<C-o>dw", { noremap = true })
vim.keymap.set("c", f.isMac() and "<A-Del>" or "<C-Del>", "<S-Right><C-W>", { noremap = true })

-- go back/forth
vim.keymap.set("n", "<A-->", "<C-o>", { desc = "go back" })
-- TODO not working on windows
vim.keymap.set("n", "<A-S-->", "<C-i>", { desc = "go forth" })

-- next/prev word
vim.keymap.set({ "n", "i", "v", "c", "o" }, f.isMac() and "<A-Right>" or "C-Right", "<S-Right>", { noremap = true })
vim.keymap.set({ "n", "i", "v", "c", "o" }, f.isMac() and "<A-Left>" or "C-Left", "<S-Left>", { noremap = true })

-- start/end line
vim.keymap.set({ "n", "v", "o" }, f.isMac() and "<D-Left>" or "<Home>", "^")
vim.keymap.set("i", f.isMac() and "<D-Left>" or "<Home>", "<C-o>^")
vim.keymap.set("c", f.isMac() and "<D-Left>" or "<Home>", "<C-b>")
vim.keymap.set({ "n", "v", "o" }, f.isMac() and "<D-Right>" or "<End>", "$")
vim.keymap.set("c", f.isMac() and "<D-Right>" or "<End>", "<C-e>")
vim.keymap.set("i", f.isMac() and "<D-Right>" or "<End>", "<C-o>$")

-- save file, update to only save to this if there are changes
vim.keymap.set("n", f.isMac() and "<D-s>" or "<C-s>", ":update<CR>")
vim.keymap.set("i", f.isMac() and "<D-s>" or "<C-s>", "<Esc>:update<CR>")

-- redo
vim.keymap.set("n", "<S-u>", "<C-r>")

-- search for selected text
vim.keymap.set("v", "/", [[y/\V<C-R>=escape(@",'/\\')<CR><CR>]], { noremap = true })

-- Clear highlighting on pressing Escape
vim.keymap.set("n", "<Esc>", "<esc>:nohlsearch<CR>", { silent = true })

-- Setting and goint to native marks
vim.keymap.set("n", "<leader>th", "mH", { noremap = true })
vim.keymap.set("n", "<leader>tj", "mJ", { noremap = true })
vim.keymap.set("n", "<leader>tk", "mK", { noremap = true })
vim.keymap.set("n", "<leader>tl", "mL", { noremap = true })

vim.keymap.set("n", "<leader>h", "`H", { noremap = true })
vim.keymap.set("n", "<leader>j", "`J", { noremap = true })
vim.keymap.set("n", "<leader>k", "`K", { noremap = true })
vim.keymap.set("n", "<leader>l", "`L", { noremap = true })
