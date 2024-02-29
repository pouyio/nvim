local create_cmd = vim.api.nvim_create_user_command

create_cmd("CloseAllBuffers", function()
	-- Get the ID of the current buffer
	local current_buffer = vim.api.nvim_get_current_buf()

	-- Get a list of all buffer IDs
	local all_buffers = vim.api.nvim_list_bufs()

	-- Iterate over all buffers
	for _, buffer_id in ipairs(all_buffers) do
		-- Check if the buffer is not the current buffer
		if buffer_id ~= current_buffer then
			-- Close the buffer
			vim.api.nvim_buf_delete(buffer_id, { force = true })
		end
	end
end, { desc = "Close all other buffers" })

create_cmd("SaveWithoutFormat", function()
	-- disable conform plugin for formatting on save
	require("conform").setup({ format_on_save = false })

	-- saving
	vim.api.nvim_command("update")

	-- enabling conform plugin, not sure if it retrieves the original config in plugins/confom.lua
	require("conform").setup({ format_on_save = true })
end, { desc = "Save file without formatting" })
