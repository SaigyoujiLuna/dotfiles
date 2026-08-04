YukiVim.pack.setup({
  imports = {
    "plugins.base",
    "plugins.treesitter",
    "plugins.ui",
    "plugins.dap",
    "plugins.lang",
    "plugins.test",
    "plugins.editor",
    "plugins.input",
  },
  after_load = function()
    vim.cmd.colorscheme("catppuccin-nvim")
  end,
})
