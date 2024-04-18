local f = require("plugins.common.utils")
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set(
			"n",
			f.isMac() and "<D-b>" or "<C-b>",
			"<cmd>Neotree toggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		)
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				width = 35,
				position = "right",
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					always_show = {},
				},
				use_libuv_file_watcher = false,
				follow_current_file = {
					enabled = true,
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		})
	end,
}
