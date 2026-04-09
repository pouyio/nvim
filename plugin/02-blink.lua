local f = require("common.utils")

vim.pack.add({
	"https://github.com/rafamadriz/friendly-snippets",
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.5.0" },
})

vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") } })
require("blink.cmp").setup({
	fuzzy = {
		implementation = "lua",
	},
	sources = {
		default = function()
			if vim.bo.filetype == "copilot-chat" then
				return {}
			end
			return { "lsp", "path", "buffer" }
		end,
	},
	keymap = {
		preset = "enter",
		[f.isMac() and "<D-i>" or "⊘"] = { "show", "hide" },
		["<C-space>"] = {},
		["<C-e>"] = {},
		["<C-p>"] = {},
		["<C-n>"] = {},
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
	},
	appearance = {
		nerd_font_variant = "normal",
	},
	signature = {
		enabled = true,
	},
	completion = {
		menu = {
			draw = {
				columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 0,
		},
	},
	snippets = {
		preset = "luasnip",
	},
})
