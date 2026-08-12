vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
vim.cmd.packadd("conform.nvim")

local f = require("common.utils")

local function use_biome_if_installed_locally(bufnr)
	local biome_info = require("conform").get_formatter_info("biome", bufnr)
	if biome_info and biome_info.available and biome_info.command:match("node_modules/.bin/biome") then
		return { "biome" }
	end
	return { "prettier" }
end

local conform = require("conform")

conform.setup({
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
	format_on_save = { lsp_format = "fallback", timeout = 500 },
})

vim.api.nvim_create_user_command("SaveWithoutFormat", function()
	conform.setup({ format_on_save = false })
	vim.api.nvim_command("update")
	conform.setup({ format_on_save = true })
end, { desc = "Save file without formatting" })
