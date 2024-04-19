return {
	"petertriho/nvim-scrollbar",
	opts = {
		-- overriding because onedark theme messes them up
		marks = {
			Search = { color = "#dd9046" },
			Error = { color = "#c53b53" },
			Warn = { color = "#ffc777" },
			Info = { color = "#0db9d7" },
			Hint = { color = "#4fd6be" },
			Misc = { color = "#c75ae8" },
		handlers = {
			handle = false,
		},
	},
}
