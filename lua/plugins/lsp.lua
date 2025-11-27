return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      { "mason-org/mason-lspconfig.nvim", opts = {}, lazy = false },
    },
    opts = {
      ensure_installed = {
        "tailwindcss",
        "jsonls",
        "emmet_language_server",
        "cssls",
        { "eslint", version = "4.8.0" }, -- latest version throwing error when no config file is found
        "lua_ls",
        "ts_ls",
        "prettier",
        "stylua",
        {
          "gopls",
          condition = function()
            return vim.fn.executable("go") == 1 -- Install only if Go is in the path
          end,
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "saghen/blink.cmp" },
      { "mason-org/mason-lspconfig.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
    },
  },
}
