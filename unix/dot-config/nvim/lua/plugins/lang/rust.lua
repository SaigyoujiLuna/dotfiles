return {
  {
    "Saecki/crates.nvim",
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    ft = "rust",
    version = vim.version.range("^9"),
    ---@type rustaceanvim.Opts
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>ca", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr, noremap = true, silent = true })
          vim.keymap.set("n", "g.", function()
            vim.cmd.RusLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr, noremap = true, silent = true })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr, noremap = true, silent = true })
          vim.keymap.set("n", "K", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, { silent = true, buffer = bufnr, noremap = true })
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
            checkOnSave = {
              enabled = false,
            },
            diagnostics = {
              enabled = false,
            },
            procMacro = {
              enable = true,
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
              watcher = "client",
            },
          },
        },
      },
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
      vim.g.rustaceanvim = opts
    end,
  },
}
