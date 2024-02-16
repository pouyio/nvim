return {
  "mg979/vim-visual-multi",
  init = function()
    vim.g.VM_maps = {
      ["Find Under"] = "<D-d>",
      ["Find Subword Under"] = "<D-d>",
      ["Add Cursor Down"] = "<D-A-Down>",
      ["Add Cursor Up"] = "<D-A-Up>",
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
