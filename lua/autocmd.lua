-- share clipboard with system if it is wsl
if vim.fn.has("wsl") == 1 then
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = vim.api.nvim_create_augroup("Yank", { clear = true }),
		callback = function()
			vim.fn.system("clip.exe", vim.fn.getreg('"'))
		end,
	})
end

vim.api.nvim_create_autocmd("CursorHold", {
	group = vim.api.nvim_create_augroup("Hold", { clear = true }),
	callback = function()
		require("custom-blamer").blameVirtText()
	end,
})
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("ClearMoved", { clear = true }),
	callback = function()
		require("custom-blamer").clearBlameVirtText()
	end,
})
vim.api.nvim_create_autocmd("CursorMovedI", {
	group = vim.api.nvim_create_augroup("ClearMovedI", { clear = true }),
	callback = function()
		require("custom-blamer").clearBlameVirtText()
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
