local f = require("plugins.common.utils")

return {
	"nvim-tree/nvim-tree.lua",
	enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
		vim.api.nvim_create_autocmd("User", {
			pattern = "NvimTreeSetup",
			callback = function()
				local events = require("nvim-tree.api").events
				events.subscribe(events.Event.NodeRenamed, function(data)
					if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
						data = data
						Snacks.rename.on_rename_file(data.old_name, data.new_name)
					end
				end)
			end,
		})

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- configure nvim-tree
		nvimtree.setup({
			view = {
				width = 35,
				side = "right",
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					quit_on_open = true,
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store", "^\\.git" },
			},
			git = {
				ignore = false,
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set(
					"n",
					"?",
					api.tree.toggle_help,
					{ desc = "Toggle help", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)
				vim.keymap.set(
					"n",
					"s",
					api.node.open.vertical,
					{ desc = "Open: Horizontal Split", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)

				local add_to_harpoon = function()
					local node = api.tree.get_node_under_cursor()
					if node and node.type == "file" then
						local filepath = node.absolute_path
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
					else
						print("No file selected or selected node is not a file")
					end
				end

				local copy_path = function()
					local node = api.tree.get_node_under_cursor()
					local filepath = node.absolute_path
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
								-- Set the unnamed register and the system clipboard register
								vim.fn.setreg('"', result)
								vim.fn.setreg("+", result)
								vim.notify("Copied: " .. result)
							else
								vim.notify("Invalid selection")
							end
						else
							vim.notify("Selection cancelled")
						end
					end)
				end

				vim.keymap.set(
					"n",
					"<leader>a",
					add_to_harpoon,
					{ desc = "Add to harpoon", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)
				vim.keymap.set(
					"n",
					"<leader>y",
					copy_path,
					{ desc = "Copy path options", buffer = bufnr, noremap = true, silent = true, nowait = true }
				)
			end,
		})
		vim.keymap.set(
			"n",
			f.isMac() and "<D-b>" or "<C-b>",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		)
	end,
}
