vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
local gitsigns = require("gitsigns")
local opts = {
	current_line_blame = true,
	current_line_blame_opts = { delay = 300 },
	current_line_blame_formatter = "        <author>, <author_time:%R> - <summary>",
	signs = {
		delete = { text = "" },
		topdelete = { text = "" },
	},
	signs_staged = {
		delete = { text = "" },
		topdelete = { text = "" },
	},
	on_attach = function(bufnr)
		-- Avoid setting the keymap before codediff to avoid conflict
		local ok, lifecycle = pcall(require, "codediff.ui.lifecycle")
		local in_codediff = ok and lifecycle.find_tabpage_by_buffer(bufnr)
		if not in_codediff then
			vim.keymap.set("n", "<A-h>", function()
				gitsigns.nav_hunk("prev")
			end, { buffer = bufnr })
			vim.keymap.set("n", "<A-l>", function()
				gitsigns.nav_hunk("next")
			end, { buffer = bufnr })
		end
		vim.keymap.set("n", "<leader>gi", gitsigns.preview_hunk)
		vim.keymap.set("n", "<leader>gu", gitsigns.reset_hunk)
		vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk)
	end,
}
gitsigns.setup(opts)

vim.pack.add({ "https://github.com/kevinhwang91/nvim-hlslens" })
vim.pack.add({ "https://github.com/petertriho/nvim-scrollbar" })

require("scrollbar.handlers.search").setup({
	override_lens = function()
		return ""
	end,
})

local f = require("common.utils")
require("scrollbar").setup({
	handlers = { handle = false },
	marks = {
		Error = { text = { f.diagnosticIcons.ERROR, f.diagnosticIcons.ERROR } },
		Warn = { text = { f.diagnosticIcons.WARN, f.diagnosticIcons.WARN } },
		Info = { text = { f.diagnosticIcons.INFO, f.diagnosticIcons.INFO } },
		Hint = { text = { f.diagnosticIcons.HINT, f.diagnosticIcons.HINT } },
		GitDelete = { text = "" },
	},
	excluded_filetypes = { "neo-tree", "neo-tree-popup", "neominimap" },
})

require("scrollbar.handlers.gitsigns").setup()
