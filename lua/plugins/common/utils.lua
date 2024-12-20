local M = {}

M.isMac = function()
	---@diagnostic disable-next-line: undefined-field -- os_uname is a reliable field
	return vim.loop.os_uname().sysname == "Darwin"
end

M.closeBuffer = function()
	local window_count = #vim.api.nvim_tabpage_list_wins(0) -- Get the number of windows in the current tab

	if window_count > 1 then
		vim.api.nvim_command("close") -- Close the window if there are multiple windows
	else
		Snacks.bufdelete() -- Calling snacks because provides a meesage if the buffer is unsaved. Works with terminal buffers as well
	end
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
