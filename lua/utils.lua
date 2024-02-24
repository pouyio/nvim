local M = {}
-- Define a function to close the buffer with :bd! if terminal or :bd otherwise
M.closeBuffer = function()
  local bufnr = vim.fn.bufnr("%")                                     -- Get the buffer number of the current buffer
  if vim.api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then -- Check if the buffer is a terminal buffer
    vim.api.nvim_command("bd!")
  else
    vim.api.nvim_command("bd")
  end
end

return M
