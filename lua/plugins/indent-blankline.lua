return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		local f = require("plugins.common.utils")
		local opts = f.isMac() and {} or { indent = { char = "│" } }
		require("ibl").setup(opts)
	end,
}
