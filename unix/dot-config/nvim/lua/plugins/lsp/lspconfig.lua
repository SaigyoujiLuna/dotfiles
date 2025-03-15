return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts_extend = {"ensure_installed"},
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      }
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim"},
    opts = {},
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      require("mason-lspconfig").setup_handlers{
        function (server_name)
          require("lspconfig")[server_name].setup{}
        end,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {"mason.nvim"},
      { "williamboman/mason-lspconfig.nvim" },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        inlay_hints = {
          enabled = true,
        },
        codelens = {
          enabled = true,
        },
        format = {

        }
      },
    },
  },
}
