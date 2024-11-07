local f = require("plugins.common.utils")

-- Function to check clipboard with retries
local function getRelativeFilepath(retries, delay)
	local relative_filepath
	for i = 1, retries do
		relative_filepath = vim.fn.getreg("+")
		if relative_filepath ~= "" then
			return relative_filepath -- Return filepath if clipboard is not empty
		end
		vim.loop.sleep(delay) -- Wait before retrying
	end
	return nil -- Return nil if clipboard is still empty after retries
end

-- Function to handle editing from Lazygit
function LazygitEdit(original_buffer)
	local current_bufnr = vim.fn.bufnr("%")
	local channel_id = vim.fn.getbufvar(current_bufnr, "terminal_job_id")

	if not channel_id then
		vim.notify("No terminal job ID found.", vim.log.levels.ERROR)
		return
	end

	vim.fn.chansend(channel_id, "\15") -- \15 is <c-o> to copy path
	-- vim.cmd("close") -- Close Lazygit

	local relative_filepath = getRelativeFilepath(5, 50)
	if not relative_filepath then
		vim.notify("Clipboard is empty or invalid.", vim.log.levels.ERROR)
		return
	end

	local winid = vim.fn.bufwinid(original_buffer)

	if winid == -1 then
		vim.notify("Could not find the original window.", vim.log.levels.ERROR)
		return
	end

	Snacks.lazygit()
	vim.fn.win_gotoid(winid)
	vim.cmd("e " .. relative_filepath)
end

function Lazygit_toggle() end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = false },
		notifier = { enabled = false },
		notify = { enabled = false },
		quickfile = { enabled = false },
		statuscolumn = { enabled = false }, -- not working :( would add folding and remove gitsigns plugin
		words = {
			debounce = 50,
			enabled = true,
		},
		lazygit = {
			win = {
				height = 0.95,
				width = 0.95,
				backdrop = false,
			},
		},
		terminal = {
			win = {
				height = 0.95,
				width = 0.95,
				backdrop = false,
			},
		},
	},
	keys = {
		{
			f.isMac() and "<D-l>" or "<C-l>",
			function()
				local current_buffer = vim.api.nvim_get_current_buf()
				Snacks.lazygit()

				-- keymap to open file and close lazygit
				vim.keymap.set("t", f.isMac() and "<D-o>" or "<C-o>", function()
					LazygitEdit(current_buffer)
				end, { buffer = true, noremap = true, silent = true })
			end,
			mode = "n",
			desc = "Open Lazygit",
		},
		{
			f.isMac() and "<D-l>" or "<C-l>",
			function()
				Snacks.lazygit()
			end,
			mode = "t",
			desc = "Close Lazygit when opened",
		},
		{
			"q", -- overrides default keymap to avoid closing the window, just toggling it
			function()
				Snacks.lazygit()
			end,
			mode = "t",
			desc = "Close Lazygit when opened",
		},
		{
			f.isMac() and "<D-j>" or "<C-j>",
			function()
				Snacks.terminal("zsh")
			end,
			desc = "Open Terminal",
		},
		{
			f.isMac() and "<D-j>" or "<C-j>",
			function()
				Snacks.terminal.toggle("zsh")
			end,
			mode = "t",
			desc = "Close Terminal when opened",
		},
		{
			"<A-n>",
			function()
				Snacks.words.jump(1, true)
			end,
			desc = "Next occurence",
		},
		{
			"<A-p>",
			function()
				Snacks.words.jump(-1, true)
			end,
			desc = "Prev occurence",
		},
	},
}
