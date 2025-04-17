return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		event = "InsertEnter",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "saghen/blink.cmp" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "j-hui/fidget.nvim", opts = {} },
		},
		init = function()
			-- Reserve a space in the gutter
			-- This will avoid an annoying layout shift in the screen
			vim.opt.signcolumn = "yes"
			vim.diagnostic.config({
				virtual_text = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = "󰌵",
					},
				},
			})
		end,
		config = function()
			local lspconfig = require("lspconfig")

			-- Add blink.cmp capabilities settings to lspconfig
			local lspconfig_defaults = lspconfig.util.default_config
			lspconfig_defaults.capabilities = require("blink.cmp").get_lsp_capabilities(lspconfig_defaults.capabilities)

			-- LspAttach is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "L", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, opts)
					vim.keymap.set("n", "H", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, opts)
					vim.keymap.set({ "n", "i" }, "<A-i>", function()
						vim.lsp.buf.hover()
					end, opts)
					-- Not used the same as vscode because wsl does not support <C-.>
					vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts) -- show code actions for errors/warns
				end,
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"tailwindcss",
					"jsonls",
					"gopls",
					"emmet_language_server",
					"cssls",
					"eslint@4.8.0", -- latest version throwing error when no config file is found
					"lua_ls",
					"ts_ls",
					-- install manually
					-- "prettier"
					-- "stylua"
				},
				handlers = {
					-- this first function is the "default handler"
					-- it applies to every language server without a "custom handler"
					function(server_name)
						lspconfig[server_name].setup({})
					end,
					cssls = function()
						lspconfig.cssls.setup({
							settings = {
								css = {
									lint = {
										-- disable because of tailwind @apply
										unknownAtRules = "ignore",
									},
								},
							},
						})
					end,
					ts_ls = function()
						lspconfig.ts_ls.setup({
							init_options = {
								preferences = {
									importModuleSpecifierPreference = "relative",
								},
							},
						})
					end,
				},
			})
		end,
	},
}
