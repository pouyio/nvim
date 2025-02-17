local create_cmd = vim.api.nvim_create_user_command

create_cmd("QuickfixListToggle", function()
	vim.cmd("copen")
end, { desc = "Toggle quickfix list" })
