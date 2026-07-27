vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/zuqini/zpack.nvim",
})
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
require("plugins-pack")
