local M = {}

M.isMac = function()
	return vim.loop.os_uname().sysname == "Darwin"
end

M.isGhostty = function()
	return os.getenv("TERM") == "xterm-ghostty"
end

M.closeBuffer = function()
	require("snacks").bufdelete()
	-- vim.api.nvim_command("bd")
end

M.diagnosticIcons = {
	ERROR = " ",
	WARN = " ",
	INFO = " ",
	HINT = "󰌵 ",
	modified = "●",
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
