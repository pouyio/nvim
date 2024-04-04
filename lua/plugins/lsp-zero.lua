return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"onsails/lspkind.nvim", -- vs-code like pictograms
		{ "j-hui/fidget.nvim", opts = {} },
	},
	init = function()
		local lsp_zero = require("lsp-zero")
		local f = require("plugins.common.utils")
		local lspkind = require("lspkind")

		lsp_zero.on_attach(function(client, bufnr)
			lsp_zero.default_keymaps({ buffer = bufnr })
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
			vim.keymap.set("n", "L", vim.diagnostic.goto_next)
			vim.keymap.set("n", "H", vim.diagnostic.goto_prev)
			vim.keymap.set({ "n", "i" }, "<A-i>", vim.lsp.buf.hover)
			-- Not used the same as vscode because wsl does not support <C-.>
			vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, { desc = "Code actions" }) -- show code actions for errors/warns
		end)

		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				-- `Enter` key to confirm completion
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- TODO Ctrl+i to trigger completion menu
				-- if set to <C-i> breaks tab in insert mode only for windows
				[f.isMac() and "<D-i>" or "<C-i>"] = cmp.mapping.complete(),
				-- Navigate between snippet placeholder
				["<C-f>"] = cmp_action.luasnip_jump_forward(),
				["<C-b>"] = cmp_action.luasnip_jump_backward(),

				-- Scroll up and down in the completion documentation
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				--['<C-d>'] = cmp.mapping.scroll_docs(4),
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})

		require("mason").setup({})
		require("mason-lspconfig").setup({
			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					-- (Optional) configure lua language server
					local lua_opts = lsp_zero.nvim_lua_ls()
					require("lspconfig").lua_ls.setup(lua_opts)
				end,
			},
		})
	end,
}
