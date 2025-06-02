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

local custom_tabs = {
	{
		"tabs",
		show_modified_status = false,
	},
}

local custom_filename = {
	{ "filename", path = 1, symbols = {
		modified = f.diagnosticIcons.modified,
	} },
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
	},
	opts = {
		options = {
			always_show_tabline = false,
		},
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
			lualine_c = custom_filename,
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
				"filetype",
			},
			lualine_y = {},
			lualine_z = custom_tabs,
		},
		inactive_sections = {
			lualine_c = custom_filename,
			lualine_x = {},
			lualine_z = custom_tabs,
		},
		extensions = {
			"neo-tree",
		},
	},
}
