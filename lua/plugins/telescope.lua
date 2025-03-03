local f = require("plugins.common.utils")

local function addToHarpoon(_, map)
	local harpoon = require("harpoon")
	map("n", "<leader>a", function()
		local selected_entry = require("telescope.actions.state").get_selected_entry()
		local item = {
			value = selected_entry.value,
			context = {
				row = 1,
				col = 0,
			},
		}
		harpoon:list():add(item)
	end)
	return true
end

return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	branch = "master",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "ThePrimeagen/harpoon" },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				dynamic_preview_title = true,
				path_display = {
					"filename_first",
				},
				mappings = {
					n = {
						[f.isMac() and "<D-f>" or "<C-f>"] = function(prompt_bufnr)
							actions.send_to_qflist(prompt_bufnr)
							actions.open_qflist()
						end,
						["s"] = actions.file_vsplit,
						["t"] = actions.file_tab,
					},
					-- cycle through history in any picker
					i = {
						["<Down>"] = actions.cycle_history_next,
						["<Up>"] = actions.cycle_history_prev,
						[f.isMac and "<D-f>" or "<C-f>"] = function(prompt_bufnr)
							actions.send_to_qflist(prompt_bufnr)
							actions.open_qflist()
						end,
					},
				},
			},
			pickers = {
				buffers = {
					initial_mode = "normal",
					theme = "dropdown",
					layout_config = {
						mirror = true,
						anchor = "N",
						width = 0.75,
					},
					attach_mappings = addToHarpoon,
				},
			},
		})
		vim.keymap.set("n", "<leader>v", function()
			builtin.buffers({
				sort_lastused = true,
				sort_mru = true,
				attach_mappings = function(_, map)
					map("n", "<leader>w", actions.delete_buffer)
					map("n", "v", actions.move_selection_next)
					map("n", "c", actions.move_selection_previous, { nowait = true })
					return true
				end,
			})
		end, { desc = "Find buffer" })
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function()
				vim.opt_local.number = true -- Enable line numbers
			end,
		})
	end,
}
