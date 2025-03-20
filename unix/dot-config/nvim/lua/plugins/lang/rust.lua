return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    ft = { "rust" },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = {
      ensure_installed = { "rust_analyzer" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = { "rust", "ron" } },
  },
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        "codelldb",
      },
    },
  },
}
