local f = require("plugins.common.utils")
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"ThePrimeagen/harpoon",
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
			commands = {
				add_to_harpoon = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local harpoon = require("harpoon")

					-- Get the project root
					local project_root = vim.fn.getcwd()

					-- Convert the absolute path to a relative path
					local relative_filepath = vim.fn.fnamemodify(filepath, ":." .. project_root)
					local item = {
						value = relative_filepath,
						context = {
							row = 1,
							col = 0,
						},
					}
					harpoon:list():add(item)
				end,
				copy_path = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local results = {
						modify(filepath, ":."),
						filename,
						filepath,
					}

					vim.ui.select({
						"1. Relative path: " .. results[1],
						"2. Filename: " .. results[2],
						"3. Absolute path: " .. results[3],
					}, { prompt = "Choose to copy to clipboard:" }, function(choice)
						if choice then
							local i = tonumber(choice:sub(1, 1))
							if i then
								local result = results[i]
								vim.fn.setreg('"', result)
								vim.notify("Copied: " .. result)
							else
								vim.notify("Invalid selection")
							end
						else
							vim.notify("Selection cancelled")
						end
					end)
				end,
			},
			window = {
				width = 35,
				position = "right",
				mappings = {
					["<leader>a"] = "add_to_harpoon",
					["<leader>y"] = "copy_path",
				},
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
