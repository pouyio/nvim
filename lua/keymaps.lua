vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jj", "<Esc>")

-- visual movement
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- select all
vim.keymap.set("n", "<D-a>", "ggVG")

-- move 9 lines up/down
vim.keymap.set({"n", "v"}, "<A-u>", "9k")
vim.keymap.set({"n", "v"}, "<A-d>", "9j")


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

-- delete full word
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})

-- go back/forth
vim.keymap.set("n", "<A-->", "<C-o>", {desc = "go back"})
vim.keymap.set("n", "<A-S-->", "<C-i>", {desc = "go forth"})

-- next/prev word macos
vim.keymap.set({'n', "i", "v"}, '<A-Right>', '<S-Right>', {noremap = true})
vim.keymap.set({'n', "i", "v"}, '<A-Left>', '<S-Left>', {noremap = true})
-- next/prev word windows
vim.keymap.set({'n', "v"}, '<C-Left>', '<S-Left>', {noremap = true})
vim.keymap.set({'n', "v"}, '<C-Right>', '<S-Right>', {noremap = true})

-- start/end line macos
vim.keymap.set({"n", "v"}, "<D-Left>", "_")
vim.keymap.set("i", "<D-Left>", "<C-o>_")
vim.keymap.set({"n", "v"}, "<D-Right>", "$")
vim.keymap.set("i", "<D-Right>", "<C-o>$")
-- start/end line windows
vim.keymap.set({"n", "v"}, "<Home>", "_")
vim.keymap.set("i", "<Home>", "<C-o>_")
vim.keymap.set({"n", "v"}, "<End>", "$")
vim.keymap.set("i", "<End>", "<C-o>$")

-- save file, update to only save to this if there are changes
vim.keymap.set("n", "<C-s>", ":update<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:update<CR>gi")