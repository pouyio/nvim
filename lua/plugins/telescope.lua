local f = require("plugins.common.utils")

return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = f.isMac() and "make"
				or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		telescope.setup({
			defaults = {
				layout_config = { width = 0.95 },
			},
			pickers = {
				buffers = {
					initial_mode = "normal",
					theme = "dropdown",
				},
				grep_string = {
					initial_mode = "normal",
				},
			},
		})
		vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>f", builtin.live_grep, { desc = "Grep String" })
    -- keymap to close buffers from selector 
		vim.keymap.set("n", "<leader>b", function()
			builtin.buffers({
				attach_mappings = function(prompt_bufnr, map)
					local actions_state = require("telescope.actions.state")
					local delete_buf = function()
						local selection = actions_state.get_selected_entry()
						vim.api.nvim_buf_delete(selection.bufnr, {})
					end

					map("n", "<leader>w", delete_buf)
					return true
				end,
			})
		end, { desc = "Find buffer" })
		vim.keymap.set("v", f.isMac() and "<D-f>" or "<C-f>", function()
			local text = f.getVisualSelected()
			builtin.grep_string({ search = text })
		end, { desc = "Find selected text" })
		vim.keymap.set("n", "gr", builtin.lsp_references)
		vim.keymap.set("n", "gd", builtin.lsp_definitions)
	end,
}
