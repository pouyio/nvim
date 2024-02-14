return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      show_close_icons = false,
      show_buffer_close_icons = false,
      diagnostics = "nvim_lsp",
    }
  }
}
