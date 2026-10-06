vim.pack.add({ "https://github.com/folke/snacks.nvim" })
local f = require("common.utils")
local TERMINAL_SHELL = "fish"
local LAZYGIT_KEYMAP = f.isMac() and "<D-l>" or "<C-l>"

local global_keys = {
	["<A-f>"] = { f.isMac() and "<A-f>" or "<C-Right>" },
	["<C-a>"] = { f.isMac() and "<C-A>" or "<Home>" },
	["<A-d>"] = { "list_scroll_down" },
	["<A-u>"] = { "list_scroll_up" },
	["s"] = "edit_vsplit",
	["t"] = "tab",
	["<Down>"] = { "history_forward", mode = "i" },
	["<Up>"] = { "history_back", mode = "i" },
	[f.isMac() and "<D-f>" or "<C-f>"] = { "qflist", mode = { "n", "i" } },
	["<C-d>"] = { "preview_scroll_down", mode = { "n", "i" } },
	["<C-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
}

local buffer_keys = {
	["<leader>w"] = "bufdelete",
	["v"] = "list_down",
	["c"] = "list_up",
}

require("snacks").setup({
	image = {},
	indent = {},
	statuscolumn = {
		left = { "sign", "git" },
		right = { "mark", "fold" },
		folds = { open = true },
		git = { patterns = { "GitSign" } },
		refresh = 100,
	},
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
		win = { height = 0.95, width = 0.95 },
	},
	picker = {
		previewers = { git = { builtin = false } },
		formatters = {
			filename = { filename_first = true, truncate = 80 },
			file = { filename_first = true, truncate = 80 },
		},
		win = {
			input = { keys = global_keys },
			list = { keys = global_keys },
		},
		sources = {
			git_log_line = { focus = "list", layout = { preset = "vertical" } },
			git_log_file = { focus = "list", layout = { preset = "vertical" } },
			buffers = {
				focus = "list",
				layout = { preset = "vertical" },
				win = {
					input = { keys = buffer_keys },
					list = { keys = buffer_keys },
				},
				preview = function(ctx)
					local previewers = require("snacks.picker.preview")
					previewers.file(ctx)
					local path = require("snacks.picker.util").path(ctx.item)
					if path then
						local relative_path = require("snacks.picker.util").truncpath(path, 999)
						ctx.preview:set_title(relative_path)
					end
				end,
			},
			grep = {
				args = { "--hidden", "-i" },
				format = "filename",
			},
			grep_word = { format = "filename" },
			files = {
				cmd = "rg",
				args = { "--files", "--hidden", "--iglob", "!.git" },
			},
			select = { focus = "list" },
			lsp_references = { focus = "list", format = "filename" },
			lsp_implementations = { focus = "list", format = "filename" },
		},
	},
})

vim.keymap.set("n", LAZYGIT_KEYMAP, function()
	Snacks.lazygit()
end, { desc = "Open Lazygit" })

vim.keymap.set("n", f.isMac() and "<D-j>" or "<C-j>", function()
	Snacks.terminal(TERMINAL_SHELL)
end, { desc = "Open Terminal" })

vim.keymap.set("t", f.isMac() and "<D-j>" or "<C-j>", function()
	Snacks.terminal.toggle(TERMINAL_SHELL)
end, { desc = "Toggle Terminal when opened" })

vim.keymap.set("n", "<A-n>", function()
	Snacks.words.jump(1, true)
end, { desc = "Next occurence" })

vim.keymap.set("n", "<A-N>", function()
	Snacks.words.jump(-1, true)
end, { desc = "Prev occurence" })

vim.keymap.set("n", "<leader>v", function()
	Snacks.picker.buffers({
		on_show = function(picker)
			picker:action("list_down")
		end,
	})
end)

vim.keymap.set("n", "<leader>p", function()
	Snacks.picker.files()
end)

vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.grep()
end)

vim.keymap.set("v", "<leader>ff", function()
	Snacks.picker.grep_word({ focus = "list", live = true })
end)

vim.keymap.set("n", "<leader>fr", function()
	Snacks.picker.resume()
end)

vim.keymap.set("n", "<leader>fg", function()
	Snacks.picker.git_log_line()
end)

vim.keymap.set("n", "<leader>fG", function()
	Snacks.picker.git_log_file()
end)

vim.keymap.set("n", "<leader>fl", function()
	Snacks.picker.git_status({ focus = "list" })
end)

vim.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references()
end, { nowait = true })

vim.keymap.set("n", "gi", function()
	Snacks.picker.lsp_implementations()
end, { nowait = true })

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

f.HighlightGroups.register(function()
	vim.api.nvim_set_hl(0, "SnacksPickerDir", vim.api.nvim_get_hl(0, { name = "Comment", link = false }))
end)

vim.api.nvim_create_user_command("CloseOtherBuffers", function()
	Snacks.bufdelete.other()
end, { desc = "Close all other buffers" })

vim.api.nvim_create_user_command("SnacksPickers", function()
	Snacks.picker()
end, { desc = "Show all Snacks pickers" })

vim.api.nvim_create_user_command("SymbolsPicker", function()
	Snacks.picker.lsp_symbols({ focus = "list" })
end, { desc = "Show Symbols for this file (Snack picker)" })

