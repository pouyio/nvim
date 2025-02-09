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
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = f.isMac() and "make"
				or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "theprimeagen/harpoon" },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local themes = require("telescope.themes")

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
						preview_cutoff = 85,
						preview_width = 85,
					},
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
				grep_string = {
					initial_mode = "normal",
				},
				live_grep = {
					additional_args = {
						"--hidden",
						"-i",
						-- still have to hide .git
					},
				},
				lsp_references = {
					initial_mode = "normal",
					show_line = false,
					attach_mappings = addToHarpoon,
				},
				lsp_definitions = {
					initial_mode = "normal",
					attach_mappings = addToHarpoon,
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
					attach_mappings = addToHarpoon,
				},
				resume = {
					initial_mode = "normal",
				},
			},
			extensions = {
				["ui-select"] = { -- show code actions in a telescope dropdown
					themes.get_dropdown({
						initial_mode = "normal",
					}),
				},
			},
		})
		vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last picker" })
		vim.keymap.set("n", "<leader>ff", builtin.live_grep, { desc = "Grep String" })
		vim.keymap.set("v", "<leader>ff", function()
			local text = f.getVisualSelected()
			builtin.live_grep({
				default_text = text,
				initial_mode = "normal",
			})
		end, { desc = "Grep Selected String" })
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
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Show references" })
		vim.api.nvim_create_autocmd("User", {
			pattern = "TelescopePreviewerLoaded",
			callback = function()
				vim.opt_local.number = true -- Enable line numbers
			end,
		})
		telescope.load_extension("ui-select")
	end,
}
