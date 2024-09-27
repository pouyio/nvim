local M = {}

M.isMac = function()
	return vim.loop.os_uname().sysname == "Darwin"
end

M.closeBuffer = function()
	local bufnr = vim.fn.bufnr("%") -- Get the buffer number of the current buffer
	local window_count = #vim.api.nvim_tabpage_list_wins(0) -- Get the number of windows in the current tab

	if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "terminal" then
		vim.api.nvim_command("bd!") -- Force close terminal buffer
	else
		if window_count > 1 then
			vim.api.nvim_command("close") -- Close the window if there are multiple windows
		else
			vim.api.nvim_command("bd") -- Close the buffer if it's the only window
		end
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
