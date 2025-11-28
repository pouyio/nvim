local f = require("plugins.common.utils")
local function use_biome_if_installed_locally(bufnr)
	local biome_info = require("conform").get_formatter_info("biome", bufnr)
	if biome_info and biome_info.available and biome_info.command:match("node_modules/.bin/biome") then
		return { "biome" }
	end

	return { "prettier" }
end

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			["javascript"] = use_biome_if_installed_locally,
			["javascriptreact"] = use_biome_if_installed_locally,
			["typescript"] = use_biome_if_installed_locally,
			["typescriptreact"] = use_biome_if_installed_locally,
			["graphql"] = use_biome_if_installed_locally,
			["css"] = { "prettier" },
			["scss"] = { "prettier" },
			["html"] = { "prettier" },
			["json"] = { "prettier" },
			["jsonc"] = { "prettier" },
			["yaml"] = { "prettier" },
			["markdown.mdx"] = { "prettier" },
			["lua"] = { "stylua" },
			["markdown"] = function()
				if not f.isMac() == 1 then
					return { "prettier" }
				end
				return {}
			end,
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout = 500,
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		vim.api.nvim_create_user_command("SaveWithoutFormat", function()
			-- disable conform plugin for formatting on save
			conform.setup({ format_on_save = false })

			-- saving
			vim.api.nvim_command("update")

			-- enabling conform plugin, not sure if it retrieves the original config in plugins/confom.lua
			require("conform").setup({ format_on_save = true })
		end, { desc = "Save file without formatting" })

		conform.setup(opts)
	end,
}
