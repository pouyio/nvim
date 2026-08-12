vim.pack.add({
	"https://github.com/selimacerbas/markdown-preview.nvim",
	"https://github.com/selimacerbas/live-server.nvim",
})
require("markdown_preview").setup({
	port = 8421,
	open_browser = true,
	debounce_ms = 300,
})