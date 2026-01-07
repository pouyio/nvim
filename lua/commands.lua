local create_cmd = vim.api.nvim_create_user_command

create_cmd("QuickfixListToggle", function()
	vim.cmd("copen")
end, { desc = "Toggle quickfix list" })

create_cmd("ClearAllMarks", function()
	vim.cmd("delmarks A-Z")
end, { desc = "Clear {A-Z} marks" })
