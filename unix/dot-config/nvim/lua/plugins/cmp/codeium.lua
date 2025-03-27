return {
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enabled_cmp_source = true,
      virtual_text = {
        enabled = false,
        key_bindings = {
          accept = false,
        },
      },
    },
    config = function(_, opts)
      YukiVim.cmp.actions.ai_accept = function()
        if require("codeium.virtual_text").get_current_completion_item() then
          vim.api.nvim_input(require("codeium.virtual_text").accept())
          return true
        end
      end
      require("codeium").setup(opts)
    end
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "Exafunction/codeium.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        compat = { "codeium"},
        providers = {
          codeium = {
            -- kind = "Codeium",
            score_offset = 100,
            async = true,
          }
        }
      },
    },
  },
  {
    "saghen/blink.compat",
    lazy = true,
    version = "*",
    optional = true,
    opts = {
      enable_events = true
    },
  }
}
