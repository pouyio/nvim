-- just to avoid annoying warning because biome uses utf-8 by default
-- and the rest of lsp's use utf-16 as recomended by the LSP spec
vim.lsp.config("biome", {
	capabilities = {
		general = {
			positionEncodings = { "utf-16" },
		},
	},
})
