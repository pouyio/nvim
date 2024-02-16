return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({

      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      auto_install = true,
      indent = {
        enable = true,
      },
      ensure_installed = {
        "bash",
        "css",
        "go",
        "graphql",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "markdown",
        "regex",
        "rust",
        "scss",
        "sql",
        "svelte",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
        "zig",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<D-A-Right>",
          node_incremental = "<D-A-Right>",
          scope_incremental = false,
          node_decremental = "<D-A-Left>",
        },
      },

    })
  end
}
