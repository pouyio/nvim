local f = require("common.utils")

vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local custom_tabs = {
	{ "tabs", show_modified_status = false },
}

local custom_filename = {
	{ "filename", path = 1, symbols = { modified = f.diagnosticIcons.modified } },
}

require("lualine").setup({
	options = {
		always_show_tabline = false,
		disabled_filetypes = { statusline = { "neominimap" } },
	},
	sections = {
		lualine_a = {
			function()
				local cwd = vim.fn.getcwd()
				return "󰉋 " .. vim.fn.fnamemodify(cwd, ":t")
			end,
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
		lualine_y = f.isMac() and {} or { "branch" },
		lualine_z = custom_tabs,
	},
	inactive_sections = {
		lualine_c = custom_filename,
		lualine_x = {},
		lualine_z = custom_tabs,
	},
	extensions = { "neo-tree" },
})