return {
  {
    "wojciech-kulik/xcodebuild.nvim",
    cond = not vim.g.vscode and vim.uv.os_uname().sysname == "Darwin",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "folke/snacks.nvim", -- (optional) to show previews

      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
    },
    ft = { "swift", "objc", "objcpp" },
    config = function()
      require("xcodebuild").setup({})
    end,
  },
}
