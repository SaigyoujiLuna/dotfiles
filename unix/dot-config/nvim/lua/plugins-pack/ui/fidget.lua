if vim.g.vscode then
  return
end
vim.pack.add({
  "https://github.com/j-hui/fidget.nvim",
})
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
