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
					{ Harpoonline.format, "filename" },
					{ "filename", path = 1, symbols = {
						modified = "●",
					} },
				},
				lualine_y = {},
			},
			extensions = {
				"neo-tree",
			},
		}
		require("lualine").setup(options)
	end,
}
