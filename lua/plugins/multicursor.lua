local f = require("plugins.common.utils")
return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")

		mc.setup()

		-- Add cursors above/below the main cursor.
		vim.keymap.set({ "n", "v" }, f.isMac() and "<D-A-Up>" or "<C-A-Up>", function()
			mc.addCursor("k")
		end)
		vim.keymap.set({ "n", "v" }, f.isMac() and "<D-A-Down>" or "<C-A-Down>", function()
			mc.addCursor("j")
		end)

		-- Add a cursor and jump to the next word under cursor.
		vim.keymap.set({ "n", "v" }, f.isMac() and "<D-d>" or "<C-d>", function()
			mc.addCursor("*")
		end)

		-- Add and remove cursors with alt + left click.
		vim.keymap.set("n", "<A-leftmouse>", mc.handleMouse)

		vim.keymap.set("n", "<esc>", function()
			if not mc.cursorsEnabled() then
				mc.enableCursors()
			elseif mc.hasCursors() then
				mc.clearCursors()
			else
				-- Default <esc> handler.
			end
		end)

		-- Customize how cursors look.
		vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
		vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
		vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
		vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
	end,
}
