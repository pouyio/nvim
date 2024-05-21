local prettier_ft = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"css",
	"scss",
	"html",
	"json",
	"jsonc",
	"yaml",
	"markdown",
	"markdown.mdx",
	"graphql",
}

local conform_formatters = function()
	local formatters = {
		["lua"] = { "stylua" },
	}
	for _, ft in ipairs(prettier_ft) do
		formatters[ft] = { "prettier" }
	end
	return formatters
end

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("conform").setup({

			formatters_by_ft = conform_formatters(),
			format_on_save = {
				lsp_fallback = true,
				timeout = 500,
			},
		})
	end,
}
