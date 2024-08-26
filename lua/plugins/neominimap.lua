return {
	"Isrothy/neominimap.nvim",
	enabled = true,
	lazy = false, -- NOTE: NO NEED to Lazy load
	-- Optional
	keys = {},
	init = function()
		vim.opt.wrap = false -- Recommended
		vim.opt.sidescrolloff = 36 -- It's recommended to set a large value
		vim.g.neominimap = {
			float = {
				minimap_width = 13,
			},
			auto_enable = true,
			click = {
				enabled = true,
				auto_switch_focus = false,
			},
			search = {
				enabled = true,
				mode = "sign",
			},
		}
	end,
}
