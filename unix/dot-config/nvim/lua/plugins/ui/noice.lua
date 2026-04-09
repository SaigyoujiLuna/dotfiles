return {
  "folke/noice.nvim",
  cond = not vim.g.vscode,
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  },
  opts = {
    preset = {
      lsp_doc_border = true,
      bottom_search = true,
    },
    cmdline = {
      format = {
        search_down = {
          view = "cmdline",
        },
        search_up = {
          view = "cmdline",
        },
      },
    },
    lsp = {
      hover = {
        enabled = true,
        ---@type NoiceViewOptions
        opts = {
          border = "rounded",
        },
      },
    },
    -- add any options here
  },
  config = function(_, opts)
    require("noice").setup(opts)
  end,
}
