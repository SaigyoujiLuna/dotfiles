local group = YukiVim.augroup("plugins-pack")
vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lua/plenary.nvim",
})
require("plugins-pack.base")
-- treesitter 不支持延迟加载
require("plugins-pack.treesitter")
require("plugins-pack.ui")
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  once = true,
  callback = function()
    require("plugins-pack.dap")
  end,
})

require("plugins-pack.lang")
require("plugins-pack.editor")
require("plugins-pack.test")
require("plugins-pack.other")
require("plugins-pack.input")
vim.cmd.colorscheme("catppuccin-nvim")
