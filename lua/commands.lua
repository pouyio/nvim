local create_cmd = vim.api.nvim_create_user_command

create_cmd("CloseOtherBuffers", function()
	Snacks.bufdelete.other()
end, { desc = "Close all other buffers" })

create_cmd("SaveWithoutFormat", function()
	-- disable conform plugin for formatting on save
	require("conform").setup({ format_on_save = false })

	-- saving
	vim.api.nvim_command("update")

	-- enabling conform plugin, not sure if it retrieves the original config in plugins/confom.lua
	require("conform").setup({ format_on_save = true })
end, { desc = "Save file without formatting" })

create_cmd("DiffThis", function()
	-- Call Gitsigns plugin command
	vim.api.nvim_command('lua require("gitsigns").diffthis("~")')
	vim.defer_fn(function()
		vim.api.nvim_command("wincmd h")
	end, 50)
end, { desc = "Open git diff file" })

create_cmd("QuickfixListToggle", function()
	vim.cmd("copen")
end, { desc = "Toggle quickfix list" })
