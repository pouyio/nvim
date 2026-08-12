vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

vim.cmd.packadd("mason.nvim")
require("mason").setup({})

vim.cmd.packadd("mason-lspconfig.nvim")
require("mason-lspconfig").setup({})

vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
require("fidget").setup({})

local tools = {
	"tailwindcss",
	"jsonls",
	"emmet_language_server",
	"cssls",
	{ "eslint", version = "4.8.0" },
	"lua_ls",
	"ts_ls",
	"prettier",
	"stylua",
}

if vim.fn.executable("go") == 1 then
	table.insert(tools, "gopls")
end

require("mason-tool-installer").setup({
	ensure_installed = tools,
})

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/neovim/nvim-lspconfig",
})
vim.cmd.packadd("nvim-lspconfig")
vim.lsp.enable({ "lua_ls" })
