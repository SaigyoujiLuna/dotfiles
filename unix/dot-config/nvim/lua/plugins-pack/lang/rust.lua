if vim.g.vscode then
  return
end
vim.pack.add({
  "https://github.com/Saecki/crates.nvim",
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9") },
})

require("crates").setup({
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
})
local package_path = YukiVim.get_pkg_path("codelldb")
local codelldb = package_path .. "/extension/adapter/codelldb"
local library_path = ""
local uname = vim.uv.os_uname().sysname
if uname == "Linux" then
  library_path = package_path .. "/extension/lldb/lib/liblldb.so"
else
  library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
end

vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "<leader>ca", function()
        vim.cmd.RustLsp("codeAction")
      end, { desc = "Code Action", buffer = bufnr, noremap = true, silent = true })
      vim.keymap.set("n", "g.", function()
        vim.cmd.RustLsp("codeAction")
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
        checkOnSave = true,
        diagnostics = {
          enabled = false,
        },
        procMacro = {
          enable = false,
        },
        files = {
          excludeDirs = {
            ".direnv",
            ".git",
            ".jj",
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
    dap = {
      adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
    },
  },
}

vim.lsp.enable("rust_analyzer", false)
vim.lsp.enable("bacon-ls", true)
vim.lsp.config("bacon-ls", {
  settings = {
    bacon_ls = {
      backend = "cargo",
      cargo = {
        command = "clippy",
        features = "all",
        allTargets = true,
      },
    },
  },
  init_options = {
    updateOnSave = true,
    updateOnSaveWaitMillis = 3000,
  },
})
