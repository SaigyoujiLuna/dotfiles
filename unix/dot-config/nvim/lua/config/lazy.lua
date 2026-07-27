vim.pack.add({
  "https://github.com/zuqini/zpack.nvim",
})
require("plugins-pack")
require("zpack").setup({
  profiling = {
    loader = true,
    require = true,
  },
  performance = {
    vim_loader = true,
  },
  cmd_prefix = "Z",
})
