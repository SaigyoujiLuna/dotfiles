return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "catppuccin", "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        -- separator_style = "slant",
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "NeoTree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
    keys = {
      { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers"},
    },
  },
}
