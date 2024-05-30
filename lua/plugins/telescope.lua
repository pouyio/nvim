local f = require("plugins.common.utils")

-- show results in file picker, first filename then path lighter
vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "\t\t.*$")
			vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
		end)
	end,
})

return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	branch = "master",
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
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				file_ignore_patterns = { ".git/" },
				dynamic_preview_title = true,
				vimgrep_arguments = {
					-- defaults
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					-- custom arg, to disable regex
					"--fixed-strings",
					-- ignore some files
					"--glob",
					"!yarn.lock",
					"--glob",
					"!package-lock.json",
				},
				path_display = {
					"filename_first",
				},
				sorting_strategy = "ascending",
				layout_config = {
					width = 0.95,
					horizontal = {
						prompt_position = "top",
					},
				},
				mappings = {
					n = {
						[f.isMac and "<D-f>" or "<C-f>"] = actions.send_to_qflist + actions.open_qflist,
					},
					-- cycle through history in any picker
					i = {
						["<Down>"] = actions.cycle_history_next,
						["<Up>"] = actions.cycle_history_prev,
						[f.isMac and "<D-f>" or "<C-f>"] = actions.send_to_qflist + actions.open_qflist,
					},
				},
			},
			pickers = {
				buffers = {
					initial_mode = "normal",
					theme = "dropdown",
				},
				grep_string = {
					initial_mode = "normal",
				},
				live_grep = {
					additional_args = {
						"--hidden",
						-- still have to hide .git
					},
				},
				lsp_references = {
					initial_mode = "normal",
					show_line = false,
				},
				lsp_definitions = {
					initial_mode = "normal",
				},
				git_status = {
					initial_mode = "normal",
				},
				find_files = {
					find_command = {
						"rg", -- Use ripgrep as the backend
						"--files", -- Search for files
						"--hidden", -- Include hidden files and directories
						"--iglob",
						"!.git", -- Exclude the .git directory
					},
				},
				resume = {
					initial_mode = "normal",
				},
			},
			extensions = {
				["ui-select"] = { -- show code actions in a telescope dropdown
					require("telescope.themes").get_dropdown({
						initial_mode = "normal",
					}),
				},
			},
		})
		vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last picker" })
		vim.keymap.set({ "n", "v" }, "<leader>ff", builtin.live_grep, { desc = "Grep String" })
		vim.keymap.set("v", "<leader>ff", function()
			local text = f.getVisualSelected()
			require("telescope.builtin").live_grep({
				default_text = text,
				initial_mode = "normal",
			})
		end, { desc = "Grep Selected String" })
		vim.keymap.set("n", "<leader>fg", builtin.git_status, { desc = "Find git status" })
		-- keymaps inside buffer picker
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
		vim.keymap.set("v", f.isMac() and "<D-f>" or "<C-f>", function()
			local text = f.getVisualSelected()
			builtin.grep_string({ search = text })
		end, { desc = "Find selected text" })
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Show references" })
		require("telescope").load_extension("ui-select")
	end,
}
