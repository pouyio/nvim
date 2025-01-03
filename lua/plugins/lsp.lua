return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = "InsertEnter",
		config = function()
			local f = require("plugins.common.utils")
			local cmp = require("cmp")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				sources = {
					{ name = "nvim_lsp" }, -- lsp
					{ name = "path" }, -- file system paths
					{ name = "buffer" }, -- text within current buffer
					{ name = "luasnip" }, -- snippets
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- `Enter` key to confirm completion
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					[f.isMac() and "<D-i>" or "⊘"] = cmp.mapping.complete(),
					-- Navigate between snippet placeholder
					["<Tab>"] = cmp.mapping(function(fallback)
						local luasnip = require("luasnip")
						if luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					-- Jump to the previous snippet placeholder
					["<S-Tab>"] = cmp.mapping(function(fallback)
						local luasnip = require("luasnip")
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }), -- Scroll up and down in the completion documentation
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<Esc>"] = cmp.mapping.abort(),
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
		end,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "j-hui/fidget.nvim", opts = {} },
		},
		init = function()
			-- Reserve a space in the gutter
			-- This will avoid an annoying layout shift in the screen
			vim.opt.signcolumn = "yes"
			vim.diagnostic.config({
				float = { border = "rounded" },
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
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
			})

			local lspconfig = require("lspconfig")

			-- Add cmp_nvim_lsp capabilities settings to lspconfig
			-- This should be executed before you configure any language server
			local lspconfig_defaults = lspconfig.util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
			)

			-- LspAttach is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "L", vim.diagnostic.goto_next, opts)
					vim.keymap.set("n", "H", vim.diagnostic.goto_prev, opts)
					vim.keymap.set({ "n", "i" }, "<A-i>", vim.lsp.buf.hover, opts)
					-- Not used the same as vscode because wsl does not support <C-.>
					vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts) -- show code actions for errors/warns
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
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
					-- lua_ls = function()
					--   -- (Optional) configure lua language server
					--   local lua_opts = lsp_zero.nvim_lua_ls()
					--   require("lspconfig").lua_ls.setup(lua_opts)
					-- end,
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
