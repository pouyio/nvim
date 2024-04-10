-- Cutlass overrides the delete operations c, C, s, S, d, D, x, X.
-- to actually just delete and not affect the current yank
return {
	"gbprod/cutlass.nvim",
	opts = {
		cut_key = "x",
	},
}
