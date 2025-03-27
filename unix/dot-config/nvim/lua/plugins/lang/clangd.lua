return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cpp" } },
  },
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        clangd = {
          capabilities = {
            offsetEncoding = { "utf-16" },
            -- textDocument = {
            --   formatting = false,
            -- },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
      },
      -- setup = {
      --   clangd = function(_, opts)
      --     require("clangd_extensions").setup({ server = opts })
      --     return false
      --   end,
      -- },
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end,
    opts = {
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = {
      ensure_installed = { "clangd" },
    },
  }
}
