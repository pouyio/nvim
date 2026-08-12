local f = require("common.utils")

vim.pack.add({ "https://github.com/romgrk/barbar.nvim" })
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

vim.g.barbar_auto_setup = false

local barbar = require("barbar")
local state = require("barbar.state")
local render = require("barbar.ui.render")

barbar.setup({
	animation = false,
	tabpages = false,
	icons = {
		button = false,
		pinned = { filename = true, buffer_index = true },
		diagnostics = { [vim.diagnostic.severity.ERROR] = { enabled = true, icon = f.diagnosticIcons.ERROR } },
		separator = { left = " " },
	},
})

f.HighlightGroups.register(function()
	local default_error_hl = vim.api.nvim_get_hl(0, { name = "ErrorMsg" })
	local default_buffer_hl = vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = "Directory" }), { bold = true })
	vim.api.nvim_set_hl(0, "BufferVisibleERROR", default_error_hl)
	vim.api.nvim_set_hl(0, "BufferCurrentERROR", default_error_hl)
	vim.api.nvim_set_hl(0, "BufferCurrent", default_buffer_hl)
	vim.api.nvim_set_hl(0, "BufferCurrentMod", default_buffer_hl)
	vim.api.nvim_set_hl(0, "BufferCurrentSign", default_buffer_hl)
end)

vim.keymap.set({ "n", "v" }, "<S-Left>", ":BufferPrevious<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Right>", ":BufferNext<CR>", { silent = true })
vim.keymap.set("n", "<", ":BufferMovePrevious<CR>", { silent = true })
vim.keymap.set("n", ">", ":BufferMoveNext<CR>", { silent = true })

local function unpin_all()
	for _, buf in ipairs(state.buffers) do
		local data = state.get_buffer_data(buf)
		data.pinned = false
	end
end

