local f = require("plugins.common.utils")
return {
	"akinsho/toggleterm.nvim",
	version = "v2.*",
	config = function()
		local opts = {
			direction = "float",
			open_mapping = f.isMac() and [[<D-j>]] or [[<C-j>]],
			float_opts = {
				border = "curved",
			},
		}
		require("toggleterm").setup(opts)
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
		function _lazygit_toggle()
			lazygit:toggle()
		end
		vim.api.nvim_set_keymap(
			"n",
			f.isMac() and "<D-l>" or "<C-l>",
			"<cmd>lua _lazygit_toggle()<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
