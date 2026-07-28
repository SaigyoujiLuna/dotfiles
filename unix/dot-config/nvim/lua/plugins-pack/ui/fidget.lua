if vim.g.vscode then
  return
end
require("fidget").setup({
  notification = {
    window = {
      winblend = 0,
    },
  },
  integration = {
    ["nvim-tree"] = {
      enabled = true,
    },
  },
})
