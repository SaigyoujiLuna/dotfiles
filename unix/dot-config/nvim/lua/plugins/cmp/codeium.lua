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
