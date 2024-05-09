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
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			float_opts = {
				width = function()
					return math.floor(vim.o.columns * 0.95)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.95)
				end,
			},
		})
		function _Lazygit_toggle()
			lazygit:toggle()
		end
		vim.keymap.set(
			{ "n", "t" },
			f.isMac() and "<D-l>" or "<C-l>",
			"<cmd>lua _Lazygit_toggle()<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
