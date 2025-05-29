return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = {
		"tiagovla/scope.nvim",
	},
	opts = {
		suppressed_dirs = { "~/", "/" },
		pre_save_cmds = { "ScopeSaveState" },
		post_restore_cmds = { "ScopeLoadState" },
	},
}
