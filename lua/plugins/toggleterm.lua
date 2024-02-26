local f = require("plugins.common.utils")
return {
	"akinsho/toggleterm.nvim",
	version = "v2.*",
	opts = {
		direction = "float",
		open_mapping = f.isMac() and [[<D-j>]] or [[<C-j>]],
		float_opts = {
			border = "curved",
		},
	},
}
