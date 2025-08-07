local f = require("plugins.common.utils")
return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
	},
	version = "v0.*",
	opts = {
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
			use_nvim_cmp_as_default = true,
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
	},
}
