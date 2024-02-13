vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jj", "<Esc>")

-- visual movement
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- select all
vim.keymap.set("n", "<C-a>", "ggVG")

-- move 9 lines up/down
vim.keymap.set("n", "<A-u>", "9k")
vim.keymap.set("v", "<A-u>", "9k")
vim.keymap.set("n", "<A-d>", "9j")
vim.keymap.set("v", "<A-d>", "9j")


-- buffers
vim.keymap.set("n", "<leader><leader>", ":b#<CR>")
vim.keymap.set("n", "<leader>c", ":bp<CR>")
vim.keymap.set("n", "<leader>v", ":bn<CR>")
vim.keymap.set("n", "<leader>w", ":bd<CR>")

-- split
vim.keymap.set("n", "L", ":vs<CR>")
vim.keymap.set("n", "J", ":sp<CR>")

-- panes
vim.keymap.set("n", "<Right>", "<C-w>l", {noremap = true})
vim.keymap.set("n", "<Left>", "<C-w>h", {noremap = true})
vim.keymap.set("n", "<Down>", "<C-w>j", {noremap = true})
vim.keymap.set("n", "<Up>", "<C-w>k", {noremap = true})


-- move selected line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move line up" })
