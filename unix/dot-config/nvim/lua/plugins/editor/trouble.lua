return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {
      auto_preview = false,
      auto_close = true,
      auto_fold = false,
      fold_open = "",
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<CR>",
        desc = "Diagnostics",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics tpgg;e filter.buf=0<CR>",
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
