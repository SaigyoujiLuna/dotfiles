return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cpp" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          capabilities = {
            offsetEncoding = { "utf-16" },
            textDocument = {
              formatting = false
            }
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
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    opts = {
      -- formatters_by_ft = {
      --   cpp = { "clang_format", lsp_format = "fallback" },
      -- },
    },
  },
}
