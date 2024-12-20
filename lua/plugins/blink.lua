local f = require("plugins.common.utils")
return {
	enabled = false, -- TODO enable when dot repeat is fixed, needed for multicursor https://github.com/Saghen/blink.cmp/issues/182
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
	},
	version = "v0.*",
	opts = {
		keymap = {
			preset = "enter",
			[f.isMac() and "<D-i>" or "⊘"] = { "show", "show_documentation", "hide_documentation" },
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
			window = {
				border = "rounded",
			},
		},
		completion = {
			menu = {
				border = "rounded",
				auto_show = true,
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
				window = {
					border = "rounded",
				},
			},
		},
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
		sources = {
			default = { "lsp", "path", "luasnip", "buffer" },
		},
	},
}
