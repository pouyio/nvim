local f = require("plugins.common.utils")

return {
  "numToStr/Comment.nvim",
  opts = {
    toggler = {
      line = f.isMac() and "<D-u>" or "<C-u>"
    },
    opleader = {
      line = f.isMac() and "<D-u>" or "<C-u>"
    }
  }
}
