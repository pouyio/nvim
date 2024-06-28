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

	vim.fn.chansend(channel_id, "\15") -- \15 is <c-o>
	vim.cmd("close") -- Close Lazygit

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

	vim.fn.win_gotoid(winid)
	vim.cmd("e " .. relative_filepath)
end

return {
	"akinsho/toggleterm.nvim",
	version = "v2.*",
	config = function()
		local opts = {
			direction = "float",
			open_mapping = f.isMac() and [[<D-j>]] or [[<C-j>]],
			float_opts = {
				border = "curved",
			},
		}
		require("toggleterm").setup(opts)
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			float_opts = {
				width = function()
					return math.floor(vim.o.columns * 0.95)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.95)
				end,
			},
		})
		function Lazygit_toggle()
			local current_buffer = vim.api.nvim_get_current_buf()
			lazygit:toggle()

			vim.api.nvim_buf_set_keymap(
				0,
				"t",
				f.isMac and "<D-e>" or "<C-e>",
				string.format([[<Cmd>lua LazygitEdit(%d)<CR>]], current_buffer),
				{ noremap = true, silent = true }
			)
		end
		vim.keymap.set(
			{ "n", "t" },
			f.isMac() and "<D-l>" or "<C-l>",
			"<cmd>lua Lazygit_toggle()<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
