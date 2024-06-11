return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "abeldekat/harpoonline", version = "v3.1.0" },
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
		local Harpoonline = require("harpoonline")
		Harpoonline.setup({
			on_update = function()
				require("lualine").refresh()
			end,
		})

		local mode_map = {
			["NORMAL"] = "N",
			["O-PENDING"] = "N?",
			["INSERT"] = "I",
			["VISUAL"] = "V",
			["V-BLOCK"] = "VB",
			["V-LINE"] = "VL",
			["V-REPLACE"] = "VR",
			["REPLACE"] = "R",
			["COMMAND"] = "!",
			["SHELL"] = "SH",
			["TERMINAL"] = "T",
			["EX"] = "X",
			["S-BLOCK"] = "SB",
			["S-LINE"] = "SL",
			["SELECT"] = "S",
			["CONFIRM"] = "Y?",
			["MORE"] = "M",
		}

		local options = {
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(s)
							return mode_map[s] or s
						end,
					},
				},
				lualine_b = {
					function()
						-- Get the current working directory
						local currentDir = vim.fn.getcwd()

						-- Extract the last folder from the path
						local lastFolder = currentDir:match("[^/]+$")
						return lastFolder
					end,
				},
				lualine_c = {
					{ Harpoonline.format, "filename" },
					{ "filename", path = 1, symbols = {
						modified = "●",
					} },
				},
				lualine_x = { "diagnostics", "diff", "filetype", "encoding" },
				lualine_y = {},
			},
			extensions = {
				"neo-tree",
			},
		}
		require("lualine").setup(options)
	end,
}
