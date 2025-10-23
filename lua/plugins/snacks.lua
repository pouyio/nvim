local f = require("plugins.common.utils")
local TERMINAL_SHELL = "fish"

local LAZYGIT_KEYMAP = f.isMac() and "<D-l>" or "<C-l>"

local global_keys = {
	["<A-f>"] = { f.isMac() and "<A-f>" or "<C-Right>" },
	["<C-a>"] = { f.isMac() and "<C-A>" or "<Home>" },
	["<A-d>"] = { "list_scroll_down" },
	["<A-u>"] = { "list_scroll_up" },
	["s"] = "edit_vsplit",
	["t"] = "tab",
	["<Down>"] = {
		"history_forward",
		mode = "i",
	},
	["<Up>"] = {
		"history_back",
		mode = "i",
	},
	[f.isMac() and "<D-f>" or "<C-f>"] = { "qflist", mode = { "n", "i" } },
	["<C-d>"] = { "preview_scroll_down", mode = { "n", "i" } },
	["<C-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
	["<leader>a"] = "add_to_harpoon",
}

local buffer_keys = {
	["<leader>w"] = "bufdelete",
	["v"] = "list_down",
	["c"] = "list_up",
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		image = {},
		indent = {},
		words = {
			debounce = 50,
			enabled = true,
			notify_jump = true,
		},
		lazygit = {
			config = {
				editPreset = "nvim-remote",
				os = {
					edit = TERMINAL_SHELL
						.. ' -c \'if test -z "$NVIM"; nvim -- {{filename}}; else; nvim --server "$NVIM" --remote-send "'
						.. LAZYGIT_KEYMAP
						.. '"; nvim --server "$NVIM" --remote {{filename}}; end\'',

					editAtLine = TERMINAL_SHELL
						.. ' -c \'if test -z "$NVIM"; nvim +{{line}} -- {{filename}}; else; nvim --server "$NVIM" --remote-send "'
						.. LAZYGIT_KEYMAP
						.. '"; nvim --server "$NVIM" --remote {{filename}}; nvim --server "$NVIM" --remote-send ":{{line}}<CR>"; end\'',
				},
			},
			win = {
				height = 0.95,
				width = 0.95,
				keys = {
					{
						LAZYGIT_KEYMAP,
						function()
							Snacks.lazygit()
						end,
						mode = "t",
					},
				},
			},
		},
		terminal = {
			win = {
				height = 0.95,
				width = 0.95,
				border = "rounded",
			},
		},
		picker = {
			actions = {
				add_to_harpoon = function(picker)
					local harpoon = require("harpoon")
					local full_path = picker:current()
					local cwd_path = picker:cwd()

					local item = {
						value = full_path.file:gsub("^" .. vim.pesc(cwd_path) .. "/", ""),
						context = {
							row = 1,
							col = 0,
						},
					}
					harpoon:list():add(item)

					vim.api.nvim_exec_autocmds("User", {
						pattern = "HarpoonRefresh", -- Use a specific pattern for better targeting
					})
				end,
			},
			previewers = {
				git = {
					builtin = false,
				},
			},
			formatters = {
				file = {
					filename_first = true,
					truncate = 80,
				},
			},
			win = {
				input = {
					keys = global_keys,
				},
				list = {
					keys = global_keys,
				},
			},
			sources = {
				git_log_line = {
					focus = "list",
					layout = {
						preset = "vertical",
					},
				},
				git_log_file = {
					focus = "list",
					layout = {
						preset = "vertical",
					},
				},
				buffers = {
					focus = "list",
					layout = {
						preset = "vertical",
					},
					win = {
						input = {
							keys = buffer_keys,
						},
						list = {
							keys = buffer_keys,
						},
					},
				},
				grep = {
					args = {
						"--hidden",
						"-i",
					},
					transform = function(item)
						item.line = ""
						return item
					end,
				},
				grep_word = {
					transform = function(item)
						item.line = ""
						return item
					end,
				},
				files = {
					cmd = "rg",
					args = {
						"--files", -- Search for files
						"--hidden", -- Include hidden files and directories
						"--iglob",
						"!.git", -- Exclude the .git directory
					},
				},
				select = {
					focus = "list",
				},
				lsp_references = {
					focus = "list",
					transform = function(item)
						item.line = ""
						return item
					end,
				},
				lsp_implementations = {
					focus = "list",
					transform = function(item)
						item.line = ""
						return item
					end,
				},
			},
		},
	},
	keys = {
		{
			LAZYGIT_KEYMAP,
			function()
				Snacks.lazygit()
			end,
			mode = "n",
			desc = "Open Lazygit",
		},
		{
			f.isMac() and "<D-j>" or "<C-j>",
			function()
				Snacks.terminal(TERMINAL_SHELL)
			end,
			desc = "Open Terminal",
		},
		{
			f.isMac() and "<D-j>" or "<C-j>",
			function()
				Snacks.terminal.toggle(TERMINAL_SHELL)
			end,
			mode = "t",
			desc = "Toggle Terminal when opened",
		},
		{
			"<A-n>",
			function()
				Snacks.words.jump(1, true)
			end,
			desc = "Next occurence",
		},
		{
			"<A-N>",
			function()
				Snacks.words.jump(-1, true)
			end,
			desc = "Prev occurence",
		},
		{
			"<leader>V", -- using telescope buffer picker for better handling deleting buffers
			function()
				Snacks.picker.buffers({
					on_show = function(picker)
						-- start in the next buffer
						picker:action("list_down")
					end,
				})
			end,
		},
		{
			"<leader>p",
			function()
				Snacks.picker.files()
			end,
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.grep()
			end,
			mode = "n",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.grep_word({
					focus = "list",
					live = true,
				})
			end,
			mode = "v",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.resume()
			end,
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_log_line()
			end,
		},
		{
			"<leader>fG",
			function()
				Snacks.picker.git_log_file()
			end,
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.git_status({ focus = "list" })
			end,
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
		},
		{
			"gi",
			function()
				Snacks.picker.lsp_implementations()
			end,
			nowait = true,
		},
	},
	config = function(_, opts)
		local custom_default = require("snacks.picker.config.layouts").default
		custom_default.layout.width = 0.95
		custom_default.layout.height = 0.9
		custom_default.layout[2].min_width = 85
		custom_default.layout[2].width = 85

		local custom_vertical = require("snacks.picker.config.layouts").vertical
		custom_vertical.layout.height = 0.95
		custom_vertical.layout.backdrop = true
		custom_vertical.layout.width = 0.8
		custom_vertical.layout[3].height = 0.8

		-- change the style of the path in all pickers
		f.HighlightGroups.register(function()
			vim.api.nvim_set_hl(0, "SnacksPickerDir", vim.api.nvim_get_hl(0, { name = "Comment", link = false }))
		end)

		vim.api.nvim_create_user_command("CloseOtherBuffers", function()
			Snacks.bufdelete.other()
		end, { desc = "Close all other buffers" })

		vim.api.nvim_create_user_command("SnacksPickers", function()
			Snacks.picker()
		end, { desc = "Show all Snacks pickers" })

		require("snacks").setup(opts)
	end,
}
