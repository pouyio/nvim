local f = require("common.utils")

vim.pack.add({ "https://github.com/jake-stewart/multicursor.nvim" })
local mc = require("multicursor-nvim")
mc.setup()

vim.keymap.set({ "n", "v" }, f.isMac() and "<D-A-Up>" or "<C-A-Up>", function()
	mc.addCursor("k")
end)
vim.keymap.set({ "n", "v" }, f.isMac() and "<D-A-Down>" or "<C-A-Down>", function()
	mc.addCursor("j")
end)
vim.keymap.set({ "n", "v" }, f.isMac() and "<D-d>" or "<C-d>", function()
	mc.addCursor("*")
end)
vim.keymap.set("n", "<A-leftmouse>", mc.handleMouse)

vim.keymap.set("n", "<esc>", function()
	if not mc.cursorsEnabled() then
		mc.enableCursors()
	elseif mc.hasCursors() then
		mc.clearCursors()
	else
		vim.cmd("nohlsearch")
		vim.cmd("echo ''")
	end
end)