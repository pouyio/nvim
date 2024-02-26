local M = {}

M.isMac = function()
  return vim.loop.os_uname().sysname == "Darwin"
end

M.closeBuffer = function()
  local bufnr = vim.fn.bufnr("%")                                     -- Get the buffer number of the current buffer
  if vim.api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then -- Check if the buffer is a terminal buffer
    vim.api.nvim_command("bd!")
  else
    vim.api.nvim_command("bd")
  end
end

M.getVisualSelected = function()
  local a_orig = vim.fn.getreg('a')
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' then
    vim.cmd([[normal! gv]])
  end
  vim.cmd([[silent! normal! "aygv]])
  local text = vim.fn.getreg('a')
  vim.fn.setreg('a', a_orig)
  print(vim.inspect(text))
  return text
end

return M
