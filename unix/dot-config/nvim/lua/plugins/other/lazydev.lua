return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    cmd = "LazyDev",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks"}}
      },
    },
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    dependencies = { "folke/lazydev.nvim" },
    optional = true,
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
