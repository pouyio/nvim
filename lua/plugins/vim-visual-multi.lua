return {
  "mg979/vim-visual-multi",
  init = function()
    local f = require("plugins.common.utils")
    vim.g.VM_maps = {
      ["Find Under"] = f.isMac() and "<C-d>" or "<D-d>",
      ["Find Subword Under"] = f.isMac() and "<C-d>" or "<D-d>",
      ["Add Cursor Down"] = f.isMac() and "<C-A-Down>" or "<D-A-Down>",
      ["Add Cursor Up"] = f.isMac() and "<C-A-Up>" or "<D-A-Up>",
      ["Undo"] = "u"
    }
    vim.g.VM_theme = "ocean"
    vim.api.nvim_set_var('VM_custom_noremaps', {
      ['<D-Right>'] = '$',
      ['<D-Left>'] = '_',
      ['<A-Right>'] = 'w',
      ['<A-Left>'] = 'b',
    })
  end
}
