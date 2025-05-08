return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    preset = {
      lsp_doc_border = true,
      bottom_search = true,
    },
    cmdline = {
      format = {
        search_down = {
          view = "cmdline"
        },
        search_up = {
          view = "cmdline"
        }
      }
    },
    lsp = {
      hover = {
        enabled = true,
        ---@type NoiceViewOptions
        opts = {
          border = "rounded"
        }
      }
    }
    -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function(_, opts)
    require("noice").setup(opts)
  end
}
