return {
  {
    "Exafunction/windsurf.nvim",
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
      require("codeium").setup(opts)
    end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "Exafunction/windsurf.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "codeium" },
        providers = {
          codeium = {
            name = "Codeium",
            module = "codeium.blink",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
  -- {
  --   "saghen/blink.compat",
  --   lazy = true,
  --   version = "*",
  --   optional = true,
  --   opts = {
  --     enable_events = true
  --   },
  -- }
}
