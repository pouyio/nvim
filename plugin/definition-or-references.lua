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
		local range = location.targetSelectionRange or location.range
		local row, col = unpack(vim.api.nvim_win_get_cursor(0))
		local on_definition = target_uri == vim.uri_from_bufnr(0)
			and range
			and (row - 1 > range.start.line or (row - 1 == range.start.line and col >= range.start.character))
			and (row - 1 < range["end"].line or (row - 1 == range["end"].line and col <= range["end"].character))
		if not target_uri or on_definition then
			require("definition-or-references").definition_or_references()
			return
		end

		-- Jump to the first definition via :cfirst, which follows 'switchbuf'
		-- (useopen: reuse a window already showing the target)
		vim.lsp.buf.definition({
			on_list = function(list)
				vim.fn.setqflist({}, " ", { title = list.title, items = { list.items[1] } })
				vim.cmd.cfirst()
			end,
		})
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
