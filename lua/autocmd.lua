vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	desc = "Resize splits when resizing window",
	group = vim.api.nvim_create_augroup("AutoAdjustResize", { clear = true }),
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- LspAttach is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "i" }, "<A-i>", function()
			vim.lsp.buf.hover()
		end, opts)
		-- Not used the same as vscode because wsl does not support <C-.>
		vim.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, opts) -- show code actions for errors/warns
	end,
})
