vim.pack.add({"https://github.com/folke/lazy.nvim"})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins.ui" },
    { import = "plugins.cmp" },
    { import = "plugins.lsp" },
    { import = "plugins.dap" },
    { import = "plugins.treesitter" },
    { import = "plugins.editor" },
    { import = "plugins.other" },
    { import = "plugins.lang" },
    { import = "plugins.test" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

