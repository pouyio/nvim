vim.pack.add({ "https://github.com/KostkaBrukowa/definition-or-references.nvim" })
require("definition-or-references").setup({
	on_references_result = function()
		Snacks.picker.lsp_references()
	end,
})
local function goto_definition_smart()
	local client = vim.lsp.get_clients({ bufnr = 0 })[1]
	if not client then
		return
	end
	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
	vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result)
		if err or not result or (vim.islist(result) and #result == 0) then
			require("definition-or-references").definition_or_references()
			return
		end

		local location = vim.islist(result) and result[1] or result
		local target_uri = location.uri or location.targetUri
		if not target_uri then
			require("definition-or-references").definition_or_references()
			return
		end

		local target_buf = vim.uri_to_bufnr(target_uri)
		local current_win = vim.api.nvim_get_current_win()

		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			if win ~= current_win and vim.api.nvim_win_get_buf(win) == target_buf then
				local range = (location.range or location.targetSelectionRange or location.targetRange).start
				vim.api.nvim_set_current_win(win)
				vim.api.nvim_win_set_cursor(win, { range.line + 1, range.character })
				return
			end
		end

		require("definition-or-references").definition_or_references()
	end)
end

vim.keymap.set("n", "gd", goto_definition_smart, { silent = true })
vim.keymap.set(
	"n",
	"gs",
	':vs<CR> <Cmd>lua require("definition-or-references").definition_or_references()<CR>',
	{ silent = true }
)
vim.keymap.set(
	"n",
	"gt",
	'<cmd>tab split | lua require("definition-or-references").definition_or_references()<CR>',
	{ silent = true }
)
