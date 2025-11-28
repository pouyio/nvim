local f = require("plugins.common.utils")

local function feedkeys(keys)
	-- Translate special keys like <Esc>, <CR>, etc.
	local termcodes = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(termcodes, "n", false)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "kk", "<Esc>")

-- more ergonomic center / top quarter
vim.keymap.set("n", "zz", "zt")
vim.keymap.set("n", "zt", "zz")

-- relative jumps add entry to jumplist
vim.keymap.set("n", "k", [[(v:count > 0 ? "m'" . v:count . 'k' : 'gk')]], { expr = true })
vim.keymap.set("n", "j", [[(v:count > 0 ? "m'" . v:count . 'j' : 'gj')]], { expr = true })

-- select all
vim.keymap.set("n", f.isMac() and "<D-a>" or "<C-a>", "ggVG", { desc = "Select all" })

-- move half screen up/down
vim.keymap.set({ "n", "v" }, "<A-u>", "15k")
vim.keymap.set({ "n", "v" }, "<A-d>", "15j")

-- more ergonomic move to paragrahp
vim.keymap.set("n", "{", "}")
vim.keymap.set("n", "}", "{")

-- buffers
vim.keymap.set("n", "<leader><leader>", ":b#<CR>", { desc = "Toggle last buffer", silent = true })
vim.keymap.set("n", "<leader>w", f.closeBuffer, { noremap = true, silent = true, desc = "Close buffer" })

-- split
vim.keymap.set("n", "<leader>s", ":vs <CR>", { desc = "Split to right" })

-- tabs
vim.keymap.set("n", ",t", ":tabnew<CR>", { silent = true, desc = "Open current buffer in new tab" })
vim.keymap.set("n", ",m", ":tabprevious<CR>", { silent = true })
vim.keymap.set("n", ",.", ":tabnext<CR>", { silent = true })
vim.keymap.set("n", ",w", ":tabclose<CR>", { silent = true })
vim.keymap.set("n", ",,", ":tabnext #<CR>", { silent = true })

-- panes
vim.keymap.set({ "n", "v" }, "<Right>", "<C-w>l", { noremap = true })
vim.keymap.set({ "n", "v" }, "<Left>", "<C-w>h", { noremap = true })
vim.keymap.set({ "n", "v" }, "<Down>", "<C-w>j", { noremap = true })
vim.keymap.set({ "n", "v" }, "<Up>", "<C-w>k", { noremap = true })

-- windows resize
vim.keymap.set("n", "<leader>rk", ":horizontal resize +10<CR>", { desc = "vertical resize +10" })
vim.keymap.set("n", "<leader>rj", ":horizontal resize -10<CR>", { desc = "vertical resize -10" })
vim.keymap.set("n", "<leader>rl", ":vertical resize +10<CR>", { desc = "horizontal resize +10" })
vim.keymap.set("n", "<leader>rh", ":vertical resize -10<CR>", { desc = "horizontal resize -10" })

-- move selected line up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "move line up" })
vim.keymap.set("n", "J", "V:m '>+1<CR>gv=gv<Esc>", { silent = true, desc = "move line down" })
vim.keymap.set("n", "K", "V:m '<-2<CR>gv=gv<Esc>", { silent = true, desc = "move line up" })

-- duplicate line
vim.keymap.set("n", "<S-A-Down>", ":t.<CR>", { desc = "Duplicate line down" })
vim.keymap.set("n", "<S-A-Up>", ":<C-u>.,.t-1<CR>", { desc = "Duplicate line up" })
vim.keymap.set("x", "<S-A-Down>", function()
	if vim.fn.mode() == "V" then
		feedkeys("yPgv") --visual-line
	else
		feedkeys("Vy'>p'[v']$") -- visual-character
	end
end, { desc = "Duplicate selected lines down" })
vim.keymap.set("x", "<S-A-Up>", function()
	if vim.fn.mode() == "V" then
		feedkeys("y'>pgv") -- visual-line
	else
		feedkeys("VyP'[v']$") -- visual-character
	end
end, { desc = "Duplicate selected lines up" })

-- delete full line
vim.keymap.set("i", "\x0b", "<C-o>D", { noremap = true })

-- delete full word
vim.keymap.set({ "i", "c" }, f.isMac() and "<A-BS>" or "<C-H>", function()
	vim.api.nvim_input("<C-w>")
end, { noremap = true })
vim.keymap.set("i", f.isMac() and "<A-Del>" or "<C-Del>", "<C-o>dw", { noremap = true })
vim.keymap.set("c", f.isMac() and "<A-Del>" or "<C-Del>", "<S-Right><C-W>", { noremap = true })

-- go back/forth
vim.keymap.set("n", "<A-->", "<C-o>", { desc = "go back" })
vim.keymap.set("n", (f.isMac() or f.isGhostty()) and "<A-S-->" or "<A-_>", "<C-i>", { desc = "go forth" })

-- next/prev word
vim.keymap.set({ "n", "i", "v", "c", "o" }, f.isMac() and "<A-f>" or "<C-Right>", "<S-Right>", { noremap = true })
vim.keymap.set({ "n", "i", "v", "c", "o" }, f.isMac() and "<A-b>" or "<C-Left>", "<S-Left>", { noremap = true })

-- start/end line
vim.keymap.set({ "n", "v", "o" }, f.isMac() and "<C-A>" or "<Home>", "^")
vim.keymap.set("i", f.isMac() and "<C-A>" or "<Home>", "<C-o>^")
vim.keymap.set("c", f.isMac() and "<C-A>" or "<Home>", "<C-b>")
vim.keymap.set({ "n", "o" }, f.isMac() and "<C-E>" or "<End>", "$")
vim.keymap.set("v", f.isMac() and "<C-E>" or "<End>", "g_") -- move to last non-blank character
vim.keymap.set("c", f.isMac() and "<C-E>" or "<End>", "<C-e>")
vim.keymap.set("i", f.isMac() and "<C-E>" or "<End>", "<C-o>$")

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

-- Annoying, pressed when deselecting too much
vim.keymap.set("n", "<S-CR>", "<Nop>", { desc = "Disable <S-CR>" })

vim.keymap.set("n", "H", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "L", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
