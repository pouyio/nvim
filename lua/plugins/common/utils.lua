local M = {}

M.isMac = function()
	return vim.loop.os_uname().sysname == "Darwin"
end

M.isGhostty = function()
	return os.getenv("TERM") == "xterm-ghostty"
end

M.closeBuffer = function()
	-- Check if there's more than one window open
	if #vim.api.nvim_list_wins() > 1 then
		-- If window is split, use :q to close the current window
		vim.api.nvim_command("q")
	else
		-- If there's only one window, use :bd to close the buffer
		vim.api.nvim_command("bd")
	end
end

M.diagnosticIcons = {
	ERROR = " ",
	WARN = " ",
	INFO = " ",
	HINT = "󰌵",
}

M.HighlightGroups = {
	_callbacks = {
		-- Trigger the ColorScheme autocommand used in the multicursor plugin
		function()
			vim.api.nvim_exec_autocmds("ColorScheme", {})
		end,
	},
	register = function(callback)
		if type(callback) == "function" then
			callback()
			table.insert(M.HighlightGroups._callbacks, callback)
		end
	end,
	executeAll = function()
		for _, callback in ipairs(M.HighlightGroups._callbacks) do
			callback()
		end
	end,
}

return M
