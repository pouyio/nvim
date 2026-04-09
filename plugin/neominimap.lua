vim.pack.add({ "https://github.com/Isrothy/neominimap.nvim" })

vim.g.neominimap = {
	auto_enable = true,
	current_line_position = "percent",
	float = { window_border = "none" },
}

vim.api.nvim_create_user_command("MinimapToggle", function()
	vim.cmd("Neominimap Toggle")
end, { desc = "Toggle minimap" })