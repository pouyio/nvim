return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local options = {
      sections = {
        lualine_a = { "mode", "buffers" },
        lualine_y = {},
      },
      extensions = {
        'nvim-tree',
      }
    }
    require("lualine").setup(options)
  end,
}
