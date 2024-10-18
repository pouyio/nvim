return {
	"RRethy/vim-illuminate",
	enabled = true,
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		modes_denylist = { "v", "V" },
	},
	config = function(_, opts)
		require("illuminate").configure(opts)

		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "VisualNOS" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "VisualNOS" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "VisualNOS" })
	end,
}
