local f = require("plugins.common.utils")
return {
	"brenton-leighton/multiple-cursors.nvim",
	version = "*",
	keys = {
		{ f.isMac() and "<D-A-Down>" or "<C-A-Down>", "<Cmd>MultipleCursorsAddDown<CR>" },
		{ f.isMac() and "<D-A-Up>" or "<C-A-Up>", "<Cmd>MultipleCursorsAddUp<CR>" },
		{ f.isMac() and "<D-d>" or "<C-d>", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" } },
		{ "<A-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" } },
	},
	opts = {
		match_visible_only = false,
		pre_hook = function()
			require("nvim-autopairs").disable()
		end,

		post_hook = function()
			require("nvim-autopairs").enable()
		end,
		custom_key_maps = {
			{
				{ "n", "x", "i" },
				{ "<D-Right>" },
				function()
					vim.cmd("normal! g$")
				end,
			},
			{
				{ "n", "x", "i" },
				{ "<D-Left>" },
				function()
					vim.cmd("normal! _")
				end,
			},
			{
				{ "n", "x", "i" },
				{ "<A-Right>" },
				function()
					vim.cmd("normal! w")
				end,
			},
			{
				{ "n", "x", "i" },
				{ "<A-Left>" },
				function()
					vim.cmd("normal! b")
				end,
			},
			{
				{ "i", "c" },
				f.isMac() and "<A-BS>" or "<C-H>",
				function()
					vim.cmd("normal! db")
				end,
			},
			{
				{ "i", "c" },
				f.isMac() and "<A-Del>" or "<C-Del>",
				function()
					vim.cmd("normal! dw")
				end,
			},
			{
				{ "i" },
				f.isMac() and "<D-u>" or "<C-u>",
				function()
					vim.cmd("normal gcci")
				end,
			},
			{
				{ "v" },
				f.isMac() and "<D-u>" or "<C-u>",
				function()
					vim.cmd("normal gcgv")
				end,
			},
			{
				{ "n" },
				f.isMac() and "<D-u>" or "<C-u>",
				function()
					vim.cmd("normal gcc")
				end,
			},
			{
				{ "n" },
				"j",
				function()
					vim.cmd("normal gj")
				end,
			},
			{
				{ "n" },
				"k",
				function()
					vim.cmd("normal gk")
				end,
			},
		},
	},
}
