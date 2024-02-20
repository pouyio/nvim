local f = require("plugins.common.utils")
return {
  "akinsho/toggleterm.nvim",
  opts = {
    direction = 'float',
    open_mapping = f.isMac() and [[<D-j>]] or [[<C-j>]]
  }
}
