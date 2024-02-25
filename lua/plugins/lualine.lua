return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local options = {
      sections = {
        lualine_c = {
          { "filename", path = 1 }
        },
        lualine_y = {},
      },
      extensions = {
        'nvim-tree',
      }
    }
    require("lualine").setup(options)
  end,
}
