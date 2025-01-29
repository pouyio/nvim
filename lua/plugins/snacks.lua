local f = require("plugins.common.utils")

-- Function to check clipboard with retries
local function getRelativeFilepath(retries, delay, callback)
	local function tryGetFilepath(remaining_retries)
		local relative_filepath = vim.fn.getreg("+")
		if relative_filepath ~= "" then
			callback(relative_filepath) -- Call the callback with the filepath if found
		elseif remaining_retries > 1 then
			vim.defer_fn(function()
				tryGetFilepath(remaining_retries - 1)
			end, delay)
		else
			callback(nil) -- Call the callback with nil if retries are exhausted
		end
	end

	tryGetFilepath(retries)
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

	getRelativeFilepath(5, 50, function(relative_filepath)
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
	end)
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		indent = {},
		scroll = {
			enabled = false, -- it breaks pasting big chunks of text
		},
		statuscolumn = { enabled = false }, -- not working :( would add folding and remove gitsigns plugin
		words = {
			debounce = 50,
			enabled = true,
			notify_jump = true,
		},
		lazygit = {
			win = {
				height = 0.95,
				width = 0.95,
				keys = {
					{
						f.isMac() and "<D-l>" or "<C-l>",
						function()
							Snacks.lazygit()
						end,
						mode = "t",
					},
				},
			},
		},
		terminal = {
			win = {
				height = 0.95,
				width = 0.95,
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
			desc = "Toggle Terminal when opened",
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
	config = function(_, opts)
		require("snacks").setup(opts)
	end,
}
