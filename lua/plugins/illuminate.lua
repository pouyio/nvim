return {
  "RRethy/vim-illuminate",
  enabled = true,
  event = {"BufReadPost", "BufNewFile"},
  config = function (_, opts)
    require("illuminate").configure(opts)
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#4f535b" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#4f535b" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#4f535b" })
  end
}

-- bg = "#8AADF4", fg = "#24273A" 
-- bg = "#A6DA95", fg = "#24273A" 
-- bg = "#ED8796", fg = "#24273A" 


