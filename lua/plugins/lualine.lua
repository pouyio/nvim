return {
	"nvim-lualine/lualine.nvim",
	dependencies = { { "abeldekat/harpoonline", version = "*" }, { "nvim-tree/nvim-web-devicons" } },
	config = function()
		local Harpoonline = require("harpoonline")
		Harpoonline.setup({
			on_update = function()
				require("lualine").refresh()
			end,
		})

		local options = {
			sections = {
				lualine_b = {
					function()
						-- Get the current working directory
						local currentDir = vim.fn.getcwd()

						-- Extract the last folder from the path
						local lastFolder = currentDir:match("[^/]+$")
						return lastFolder
					end,
					"branch",
					"diff",
					"diagnostics",
				},
				lualine_c = {
					{ "filename", path = 1 },
					{ Harpoonline.format, "filename" },
				},
				lualine_y = {},
			},
			extensions = {
				"nvim-tree",
			},
		}
		require("lualine").setup(options)
	end,
}
