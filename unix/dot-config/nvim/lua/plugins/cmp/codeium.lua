return {
  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enabled_cmp_source = true,
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = false,
        }
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "codeium.nvim", "saghen/blink.compat" },
    opts = {
      sources = {
        providers = {
          codeium = {
            name = "codeium",
            module = "blink.compat.source",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
