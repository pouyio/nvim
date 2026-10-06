vim.pack.add({
	"https://github.com/esmuellert/codediff.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
})
vim.keymap.set("n", "<leader>dD", "<cmd>CodeDiff<cr>", { desc = "Code diff" })
vim.keymap.set("n", "<leader>dd", function()
	local base
	for _, branch in ipairs({ "main", "master" }) do
		vim.fn.system("git rev-parse --verify " .. branch .. " 2>/dev/null")
		if vim.v.shell_error == 0 then
			base = branch
			break
		end
	end
	if not base then
		vim.notify("No main or master branch found", vim.log.levels.WARN)
		return
	end
	vim.cmd("CodeDiff " .. base .. "...")
end, { desc = "Code diff vs main/master" })
require("codediff").setup({
	explorer = { view_mode = "tree" },
	keymaps = {
		view = {
			next_file = "<S-Down>",
			prev_file = "<S-Up>",
			next_hunk = "<A-l>",
			prev_hunk = "<A-h>",
			open_in_prev_tab = "e",
			close_on_open_in_prev_tab = true,
		},
	},
})
