local f = require("plugins.common.utils")

return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = f.isMac() and "make" or
          "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    }
  },
  config = function()
    local builtin = require("telescope.builtin")
    local telescope = require("telescope")

    telescope.setup {
      defaults = {
        layout_config = { width = 0.95 },
      },
      pickers = {
        buffers = {
          initial_mode = "normal",
          theme = "dropdown"
        },
        grep_string = {
          initial_mode = "normal"
        }
      }
    }
    vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set('n', '<leader>f', builtin.live_grep, { desc = "Grep String" })
    vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = "Find buffer" })
    vim.keymap.set('n', f.isMac() and '<D-f>' or '<C-f>', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', "gr", builtin.lsp_references)
    vim.keymap.set('n', "gd", builtin.lsp_definitions)
  end
}
