local M = {}

M.isMac = function()
  return vim.loop.os_uname().sysname == "Darwin"
end

return M
