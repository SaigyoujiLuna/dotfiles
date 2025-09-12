return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false,
    ft = { "rust" },
    ---@type rustaceanvim.Opts
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>ca", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
          vim.keymap.set("n", "K", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, { silent = true, buffer = bufnr })
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enabled = true,
              },
            },
            checkOnSave = false,
            diagnostics = {
              enabled = false,
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
            },
          },
        },
      },
      tools = {
        float_win_config = {
          auto_focus = true,
        }
      }
    },
    config = function(_, opts)
      local package_path = YukiVim.get_pkg_path("codelldb")
      local codelldb = package_path .. "/extension/adapter/codelldb"
      local library_path = ""
      local uname = io.popen("uname"):read("*l")
      if uname == "Linux" then
        library_path = package_path .. "/extension/lldb/lib/liblldb.so"
      else
        library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
      end
      opts.dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
      }
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
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
        "bacon",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bacons_ls = {
          enabled = true,
        },
        rust_analyzer = {
          enabled = false,
        },
      },
    },
  },
}
