return {
  "mg979/vim-visual-multi",
  init = function()
    local f = require("plugins.common.utils")
    vim.g.VM_maps = {
      ["Find Under"] = f.isMac() and "<D-d>" or "<C-d>",
      ["Find Subword Under"] = f.isMac() and "<D-d>" or "<C-d>",
      ["Add Cursor Down"] = f.isMac() and "<D-A-Down>" or "<C-A-Down>",
      ["Add Cursor Up"] = f.isMac() and "<D-A-Up>" or "<C-A-Up>",
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
