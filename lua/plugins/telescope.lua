return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find Files" })
    -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Grep String" })
    -- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Grep word" })
    -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find old files" })
  end
    }
