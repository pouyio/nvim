local f = require("plugins.common.utils")
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

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "letieu/harpoon-lualine" },
		{ "nvim-tree/nvim-web-devicons" },
	},
	opts = {
		sections = {
			lualine_a = {
				function()
					-- Get the current working directory
					local cwd = vim.fn.getcwd()

					-- Extract the last folder from the path
					return "󰉋 " .. vim.fn.fnamemodify(cwd, ":t")
				end,
				{
					"mode",
					fmt = function(s)
						return mode_map[s] or s
					end,
				},
			},
			lualine_b = {},
			lualine_c = {
				{
					"harpoon2",
					indicators = { " 1 ", " 2 ", " 3 ", " 4 " },
					_separator = "",
				},
				{ "filename", path = 1, symbols = {
					modified = "●",
				} },
			},
			lualine_x = {
				{
					"diagnostics",
					symbols = {
						error = f.diagnosticIcons.ERROR,
						warn = f.diagnosticIcons.WARN,
						info = f.diagnosticIcons.INFO,
						hint = f.diagnosticIcons.HINT,
					},
				},
				"diff",
				"filetype",
			},
			lualine_y = {},
		},
		extensions = {
			"neo-tree",
		},
	},
}
