local group = YukiVim.augroup("plugins-pack-input")

vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/huijiro/blink-cmp-supermaven",
  "https://github.com/supermaven-inc/supermaven-nvim",
})
vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  group = group,
  once = true,
  callback = function()
    require("plugins-pack.input.blink")
    require("plugins-pack.input.ai")
    require("plugins-pack.input.surround")
    require("plugins-pack.input.autopairs")
    require("plugins-pack.input.leap")

  end,
})
