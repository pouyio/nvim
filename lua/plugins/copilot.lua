local f = require("plugins.common.utils")
return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		enabled = f.isMac(),
		opts = {
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<Tab>",
				},
			},
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		event = "VeryLazy",
		enabled = f.isMac(),
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-3.7-sonnet",
							},
						},
					})
				end,
			},
			strategies = {
				chat = {
					keymaps = {
						stop = {
							modes = {
								n = "<C-c>", -- Changed from "q" to "<C-q>"
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("codecompanion").setup(opts)
			vim.keymap.set(
				{ "n", "v" },
				f.isMac() and "<D-k>" or "<C-k>",
				"<cmd>CodeCompanionChat Toggle<CR>",
				{ desc = "Code Companion Chat" }
			)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "codecompanion",
				callback = function(event)
					vim.keymap.set({ "n", "v" }, "q", "<cmd>CodeCompanionChat Toggle<CR>", {
						buffer = event.buf,
						desc = "Toggle CodeCompanion Chat",
						nowait = true,
					})
				end,
			})
		end,
	},
}
