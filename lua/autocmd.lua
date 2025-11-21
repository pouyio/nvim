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
