vim.pack.add({ "https://github.com/zuqini/zpack.nvim" })
require("plugins.treesitter.treesitter")
require("plugins.dap.core")
require("plugins.test.neotest")

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
