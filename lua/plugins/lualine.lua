return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "letieu/harpoon-lualine" },
		{ "nvim-tree/nvim-web-devicons" },
	},
	config = function()
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

		local allSections = {
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
					local cwd = vim.fn.getcwd()

					-- Extract the last folder from the path
					return vim.fn.fnamemodify(cwd, ":t")
				end,
			},
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
			lualine_x = { "diagnostics", "diff", "filetype", "encoding" },
			lualine_y = {},
		}
		local opts = {
			options = {
				component_separators = "",
				section_separators = "",
			},
			sections = allSections,
			inactive_sections = allSections,
			extensions = {
				"neo-tree",
			},
		}
		require("lualine").setup(opts)
	end,
}
