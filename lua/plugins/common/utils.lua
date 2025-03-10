local M = {}

M.isMac = function()
	return vim.loop.os_uname().sysname == "Darwin"
end

M.isGhostty = function()
	return os.getenv("TERM") == "xterm-ghostty"
end

M.closeBuffer = function()
	vim.api.nvim_command("bd")
end

M.getVisualSelected = function()
	local a_orig = vim.fn.getreg("a")
	local mode = vim.fn.mode()
	if mode ~= "v" and mode ~= "V" then
		vim.cmd([[normal! gv]])
	end
	vim.cmd([[silent! normal! "aygv]])
	local text = vim.fn.getreg("a")
	vim.fn.setreg("a", a_orig)
	print(vim.inspect(text))
	return text
end

return M
