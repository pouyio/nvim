return {
	"navarasu/onedark.nvim",
	config = function()
		require("onedark").setup({
			style = "deep",
			code_style = {
				functions = "bold",
			},
			colors = {
				bg3 = "#4c5263",
			},
		})
		vim.cmd.colorscheme("onedark")
	end,
}
