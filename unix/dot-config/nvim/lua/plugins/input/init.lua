local M = {}

return {
  packages = {
    { src = "https://github.com/saghen/blink.lib" },
    { src = "https://github.com/saghen/blink.cmp" },
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/supermaven-inc/supermaven-nvim",
    "https://codeberg.org/andyg/leap.nvim",
  },
  build = {
    ["blink.cmp"] = function()
      require("blink.cmp"):build():pwait()
    end,
  },
  config = function()
    local group = YukiVim.augroup("plugins-input")
    vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
      group = group,
      once = true,
      callback = function()
        require("plugins.input.blink")
        require("plugins.input.ai")
        require("plugins.input.leap")
      end,
    })
  end,
}
