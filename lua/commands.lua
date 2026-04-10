local create_cmd = vim.api.nvim_create_user_command

create_cmd("QuickfixListToggle", function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			qf_exists = true
			break
		end
	end

	if qf_exists then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end, { desc = "Toggle quickfix list" })

create_cmd("ClearAllMarks", function()
	vim.cmd("delmarks A-Z")
end, { desc = "Clear {A-Z} marks" })
