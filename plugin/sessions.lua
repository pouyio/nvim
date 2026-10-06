vim.pack.add({ "https://github.com/rmagatti/auto-session" })
vim.pack.add({ "https://github.com/tiagovla/scope.nvim" })
require("scope").setup({})
require("auto-session").setup({
	suppressed_dirs = { "~/", "/" },
	pre_save_cmds = { "ScopeSaveState" },
	post_restore_cmds = { "ScopeLoadState" },
})