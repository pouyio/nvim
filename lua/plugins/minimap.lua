---@module "neominimap.config.meta"
return {
	"Isrothy/neominimap.nvim",
	version = "v3.x.x",
	lazy = false, -- NOTE: NO NEED to Lazy load
	init = function()
		-- vim.opt.wrap = false
		-- vim.opt.sidescrolloff = 36 -- Set a large value

		--- Put your configuration here
		vim.g.neominimap = {
			auto_enable = true,
			layout = "split",
			current_line_position = "percent",
		}

		vim.api.nvim_create_user_command("MinimapToggle", function()
			vim.cmd("Neominimap Toggle")
		end, { desc = "Toggle minimap" })
	end,
}
