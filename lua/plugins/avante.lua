local f = require("plugins.common.utils")

return {
	"yetone/avante.nvim",
	enabled = f.isMac() and true or false,
	event = "VeryLazy",
	lazy = false,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		provider = "copilot",
		mappings = {
			ask = "<leader>dd",
			edit = "<leader>de",
			refresh = "<leader>dr",
			submit = { insert = f.isMac() and "<D-CR>" or "<C-CR>" },
		},
	},
	config = function(_, opts)
		require("avante_lib").load()
		vim.opt.laststatus = 3 -- Always show the status line, recomended by ava
		vim.keymap.set(
			"n",
			f.isMac() and "<D-y>" or "<C-y>",
			":AvanteChat<CR>",
			{ silent = true, desc = "Toggle avante chat" }
		)
		vim.keymap.set(
			"i",
			f.isMac() and "<D-y>" or "<C-y>",
			"<ESC>:AvanteChat<CR>",
			{ silent = true, desc = "Toggle avante chat" }
		)

		require("avante").setup(opts)
	end,
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make BUILD_FROM_SOURCE=true",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
