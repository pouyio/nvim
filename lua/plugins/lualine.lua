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
	"tabs",
	mode = 1,
	show_modified_status = false,
	fmt = function(name, context)
		-- Get all window names in the current tabpage
		local buflist = vim.fn.tabpagebuflist(context.tabnr)
		local window_names = {}

		-- Collect all window names from buffers in this tabpage
		for _, bufnr in ipairs(buflist) do
			local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
			-- Only add non-empty names
			if name and name ~= "" then
				table.insert(window_names, name)
			end
		end

		-- Join window names with comma
		if #window_names > 0 then
			return table.concat(window_names, "|")
		else
			return "[No Name]"
		end
	end,
}

local custom_filename = {
	"filename",
	path = 1,
	symbols = {
		modified = "●",
	},
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", "letieu/harpoon-lualine" },
	},
	opts = {
		-- options = {
		-- 	always_show_tabline = false,
		-- },
		tabline = {
			lualine_a = { "filename" },
			lualine_z = { custom_tabs },
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
			lualine_c = { { "harpoon2", indicators = { " 1 ", " 2 ", " 3 ", " 4 " }, _separator = "" }, custom_filename },
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
			lualine_z = { custom_tabs },
		},
		inactive_sections = {
			lualine_c = { custom_filename },
			lualine_x = {},
		},
		extensions = {
			"neo-tree",
		},
	},
}
