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

local function filenameFirst(_, path)
	local tail = vim.fs.basename(path)
	local parent = vim.fs.dirname(path)
	if parent == "." then
		return tail
	end
	return string.format("%s\t\t%s", tail, parent)
end

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
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		telescope.setup({
			defaults = {
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
				},
				path_display = filenameFirst,
				sorting_strategy = "ascending",
				layout_config = {
					width = 0.95,
					horizontal = {
						prompt_position = "top",
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
				lsp_references = {
					initial_mode = "normal",
				},
				lsp_definitions = {
					initial_mode = "normal",
				},
				git_status = {
					initial_mode = "normal",
					theme = "dropdown",
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
		vim.keymap.set({ "n", "v" }, "<leader>ff", builtin.live_grep, { desc = "Grep String" })
		vim.keymap.set("v", "<leader>ff", function()
			local text = f.getVisualSelected()
			require("telescope.builtin").live_grep({
				default_text = text,
			})
		end, { desc = "Grep Selected String" })
		vim.keymap.set("n", "<leader>fg", builtin.git_status, { desc = "Find git status" })
		-- keymap to close buffers from selector
		vim.keymap.set("n", "<leader>v", function()
			builtin.buffers({
				sort_lastused = true,
				sort_mru = true,
				attach_mappings = function(_, map)
					local actions = require("telescope.actions")
					local actions_state = require("telescope.actions.state")
					local delete_buf = function()
						local selection = actions_state.get_selected_entry()
						vim.api.nvim_buf_delete(selection.bufnr, {})
					end

					map("n", "<leader>w", delete_buf)
					map("n", "v", actions.move_selection_next)
					map("n", "c", actions.move_selection_previous)
					return true
				end,
			})
		end, { desc = "Find buffer" })
		vim.keymap.set("v", f.isMac() and "<D-f>" or "<C-f>", function()
			local text = f.getVisualSelected()
			builtin.grep_string({ search = text })
		end, { desc = "Find selected text" })
		vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Show references" })
		vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Show definitions" })
		require("telescope").load_extension("ui-select")
	end,
}
