vim.pack.add({
	"https://github.com/selimacerbas/mdkite.nvim",
	"https://github.com/selimacerbas/kitehost.nvim",
})
require("mdkite").setup({
	port = 8421,
	open_browser = true,
	debounce_ms = 300,
})
