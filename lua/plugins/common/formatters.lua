local M = {}

local prettier_ft = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "css",
  "scss",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
}

M.conform_formatters = function()
  local formatters = {
    ["lua"] = { "stylua" },
  }
  for _, ft in ipairs(prettier_ft) do
    formatters[ft] = { "prettier" }
  end
  return formatters
end


return M
