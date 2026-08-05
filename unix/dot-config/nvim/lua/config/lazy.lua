YukiVim.pack.setup({
  imports = {
    "plugins.base",
    "plugins.ui",
    "plugins.treesitter",
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
